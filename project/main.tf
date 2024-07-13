# Declare the data resource for availability zones
data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id

  subnet_ids     = module.vpc.public_subnet_ids
  security_group = module.vpc.web_security_group_id

  availability_zones = data.aws_availability_zones.available.names
}

module "rds" {
  source         = "./modules/rds"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  security_group = module.vpc.rds_security_group_id
}

module "s3" {
  source = "./modules/s3"
}

resource "aws_codepipeline" "webapi_pipeline" {
  name = "webapi-ci-cd-pipeline"

  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = module.s3.codepipeline_bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.repository_name
        BranchName     = var.branch_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      # configuration = {
      #   Name = aws_codebuild_project.webapi_build.name
      #   ApplicationName     = aws_codedeploy_deployment_group.webapi.application_name
      #   DeploymentGroupName = aws_codedeploy_deployment_group.webapi.deployment_group_name
      # }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["build_output"]

      # configuration = {
      #   ApplicationName     = aws_codedeploy_app.webapi.name
      #   # DeploymentGroupName = aws_codedeploy_deployment_group.webapi.name
      # }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
  })

  inline_policy {
    name   = "codepipeline_policy"
    policy = file("codepipeline_policy.json")
  }
}

resource "aws_codebuild_project" "webapi_build" {
  name          = "webapi-build"
  description   = "Build project for .NET WebAPI"
  build_timeout = 5
  service_role  = aws_iam_role.codepipeline_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec.yml")
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_SOURCE_CACHE", "LOCAL_DOCKER_LAYER_CACHE"]
  }
}

resource "aws_codedeploy_app" "webapi" {
  name = "webapi-deploy-app"
}

resource "aws_codedeploy_deployment_group" "webapi" {
  app_name              = aws_codedeploy_app.webapi.name
  deployment_group_name = "webapi-deployment-group"
  service_role_arn      = aws_iam_role.codepipeline_role.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  load_balancer_info {
    elb_info {
      name = module.ec2.elb_name
    }
  }

  ec2_tag_set {
    ec2_tag_filter {
      key    = "Name"
      value  = "webapi-instance"
      type   = "KEY_AND_VALUE"
    }
    # You can add more ec2_tag_filter blocks as needed for other tags
  }
}

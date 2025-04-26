# Apollo Platform Engineer Take-Home Task

**Keep the content of this test task, your thoughts and work on it confidential.**

# Logistics

* You have 3 hours to complete the task.  
* You have to record your screen throughout the task, and send us the final recording by uploading to the Google Drive folder you shared with us through the Google Form earlier.  
* Don't worry if you're unable to finish the task, we're interested in how you approach it — not just the end result.  
* Written comments and guidance about what you're doing and why are really helpful\! For example, you could add them in a supplementary README file. Note: we are unable to review audio comments from your recording.
* You're not allowed to consult other people during the task and you're not allowed to share it with anyone else, nor discuss its contents even after you complete the task.

## Use of external tools

* You are allowed but not required to use LLM chatbots or agents to help you solve this task under the following conditions:  
  * Any tools used should be publicly available.  
  * You should include any use of LLM tools in the screen recording that you submit.  
* You can copy code from Stack Overflow if you think this is the best way of solving the task.  
* You can use any public cloud resources, but try to minimize costs where possible.  
* You can use any publicly available tools or libraries that you find helpful.

# Background

## Agent evals

At Apollo, we run AI evaluations (evals) to test how well AI agents perform on specific tasks. AI agents are systems that can interact with their environment to complete tasks. Unlike basic models that simply respond to prompts, agents can use tools like code execution, file operations, or web search.

## Sandboxes
When evaluating agents, we often need to let them run code. This creates security risks if not properly contained. That's why we use sandboxed environments - isolated spaces where agents can safely execute code without affecting the host system.

## Inspect AI and sandboxing

[Inspect AI](https://inspect.aisi.org.uk/) is a python library which we use at Apollo for implementing and running evals. It supports different types of sandboxes:

1. **Local filesystem**: Run code in the same environment as the evaluation (useful only when already in another sandbox)
2. **Docker containers**: Run code in isolated containers on the local machine
3. **Kubernetes**: Run code in containers within a Kubernetes cluster (using the [Inspect K8s Sandbox](https://github.com/UKGovernmentBEIS/inspect_k8s_sandbox) plugin)

During this task, you'll deploy and configure a Kubernetes sandbox.

# Task

## Requirements

Your task is to deploy a Kubernetes cluster in AWS or your preferred cloud that can run the included sample evaluations.

Please implement the following requirements in descending order of priority:

1. Deploy a Kubernetes cluster using Infrastructure as Code (IaC), in your preferred cloud.
2. Install the [Inspect K8s Sandbox](https://github.com/UKGovernmentBEIS/inspect_k8s_sandbox) ensure you can run the attached sample task.
3. Implement security controls that restrict researchers to accessing only their own tasks. Ensure that when multiple researchers use the system simultaneously, one researcher cannot view, modify, or interfere with another researcher's sandboxed tasks or results.
4. Ensure that researchers can run Inspect tasks using the k8s sandbox from either their local machine or a remote development environment (such as a cloud VM instance like EC2, Compute Engine, or Azure VM) while ensuring the sandbox containers always run within the Kubernetes cluster.
5. Enable researchers to specify custom node types (e.g., CPU or GPU) for their tasks. Demonstrate this functionality using at least two different non-GPU node types. Note: for this task, you do not need to deploy actual GPU nodes.

We expect that even very strong candidates may not fully complete all steps. Focus on demonstrating your approach and document any trade-offs or further improvements you would consider for a production environment.

## Deliverables

* Infrastructure as Code
* Deployment instructions
* Brief architectural documentation

## Provided code

### Contents
This package contains a sample task which can be run locally.

You can use this task to test your cluster once it's been deployed.

### Usage

1. Create a virtual environment and activate it. If you have already created a virtual environment, you can skip this step.
   ```bash
   python -m venv .venv
   source ./.venv/bin/activate
   ```

2. Install the package and its dependencies.
   ```
   pip install -e .
   ```

3. Run the sample task.
   ```bash
   inspect eval sample_task.py
   ```

4. View the logs.
   ```bash
   inspect view
   ```


## How to submit the task

Please upload your code and any additional material that you used or produced during the task to the Google Drive directory you created earlier. Include the video recording.

We will penalize late submissions. We understand that screen recordings may take longer to upload and it's fine if they get uploaded after the deadline.

## How we will evaluate your submission

We will review your final submission. We may also look through the video recording to understand your process. We won't review audio from the recording.

You will be evaluated on the following criteria (in no particular order):

* Correctness
* Security
* Usability
* Code quality
* Documentation
* Problem solving approach and technical decisions

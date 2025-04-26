# Base Image
FROM python:3.12-slim

# Set working directory
WORKDIR /apollo-k8s-task

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy project files into container
COPY ../ /apollo-k8s-task/

# Set working directory inside project
WORKDIR /apollo-k8s-task

# Install Python dependencies
RUN pip3 install --upgrade pip \
    && pip3 install "setuptools>=61.0" "wheel" \
    && pip3 install inspect_ai==0.3.90 \
    && pip3 install git+https://github.com/UKGovernmentBEIS/inspect_k8s_sandbox.git@038794e9323a8e2db4bcebb7d54ba5f05fcd0b23
# Install your local project (editable mode)
RUN pip3 install -e .
# RUN pip3 install /apollo-k8s-task

# Entrypoint (optional)
CMD ["inspect", "eval", "sample_task.py"]
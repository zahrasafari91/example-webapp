#!/bin/bash
set -e
set -x

STACK_NAME=$1
ALB_LISTENER_ARN=$2

aws cloudformation deploy \
    --region us-east-2 \
    --stack-name $STACK_NAME \
    --template-file service.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
    "DockerImage=237997119181.dkr.ecr.us-east-2.amazonaws.com/example-webapp-zsafarialamoti097:$(git rev-parse HEAD)" \
    "VPC=vpc-6b1a9700" \
    "Subnet=subnet-4994de05" \
    "Cluster=default" \
    "Listener=$ALB_LISTENER_ARN"
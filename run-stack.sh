#!/bin/bash

aws cloudformation deploy \
    --region us-east-2 \
    --stack-name example-webapp-production \
    --template-body file://service.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
    ParameterKey=DockerImage,ParameterValue=237997119181.dkr.ecr.us-east-2.amazonaws.com/example-webapp-zsafarialamoti097:$(git rev-parse HEAD) \
    ParameterKey=VPC,ParameterValue=vpc-6b1a9700 \
    ParameterKey=Cluster,ParameterValue=default \
    ParameterKey=Listener,ParameterValue=arn:aws:elasticloadbalancing:us-east-2:237997119181:listener/app/production-website/18f0633cae96d151/5d163e7f55bcb746
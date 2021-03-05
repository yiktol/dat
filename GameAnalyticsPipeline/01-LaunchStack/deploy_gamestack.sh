#!/bin/bash


echo "Initializing Variables"
sleep 2
stackName='GameStack'
bucketName='yikyakyukbucket01'

echo "Deploying GameStack"
sleep 2
aws cloudformation deploy \
--template-file game-analytics-pipeline.template.yaml \
--stack-name $stackName \
--capabilities CAPABILITY_IAM  \
--s3-bucket $bucketName \
--s3-prefix $stackName

echo 'Done'
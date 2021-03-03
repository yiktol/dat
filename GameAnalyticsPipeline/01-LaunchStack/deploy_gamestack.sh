#!/bin/bash


echo 'Initializing Variables'
sleep 1
stackName='GameStack'
bucketName='yikyakyukbucket01'

echo 'Deploying GameStack'
sleep 1
aws cloudformation deploy \
--template-file game-analytics-pipeline.template.yaml \
--stack-name $stackName \
--capabilities CAPABILITY_IAM  \
--s3-bucket $bucketName \
--s3-prefix $stackName

echo 'Done'
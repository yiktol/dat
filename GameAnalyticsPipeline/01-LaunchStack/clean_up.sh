

echo ' Initialise Variables'
sleep 2
stackName='GameStack'
bucketName='yikyakyukbucket01'
region=$(aws configure get region)


echo 'Delete Stack'
sleep 2
aws cloudformation delete-stack \
    --stack-name $stackName


echo 'Delete Buckets'
sleep 2
buckets=$(aws s3api list-buckets | jq -r '.Buckets[].Name | select(startswith("gamestack"))')

for bucket in $buckets; do
echo $bucket

#Delete Objects in a Bucket
aws s3 rm s3://$bucket --recursive

#Delete Bucket
aws s3api delete-bucket \
--bucket $bucket \
--region $region
done


echo 'Delete Template'
sleep 2
#Delete the template
aws s3 rm s3://$bucketName/$(aws s3api list-objects-v2 --bucket $bucketName | jq -r '.Contents[].Key | select(startswith("GameStack"))')


echo 'Delete Cloudwatch LogGroups'
sleep 2
#Delete Cloudwatch LogGroups

loggroups=$(aws logs describe-log-groups | jq -r '.logGroups[].logGroupName | select(startswith("/aws/lambda/GameStack")),select(startswith("API-Gateway-Execution-Logs")),select(startswith("/aws/kinesisfirehose/GameStack")),select(startswith("/aws/apigateway/welcome"))')

for loggroup in $loggroups; do
echo 'Deleting ' $loggroup
aws logs delete-log-group --log-group-name $loggroup
done

echo 'Done'
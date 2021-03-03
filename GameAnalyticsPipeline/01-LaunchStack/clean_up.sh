
stackName='GameStack'
bucketName='yikyakyukbucket01'
region=$(aws configure get region)

aws cloudformation delete-stack \
    --stack-name $stackName

buckets=$(aws s3api list-buckets \
| jq -r '.Buckets[].Name \
| select(startswith("gamestack"))')

for bucket in $buckets; do
echo $bucket

#Delete Objects in a Bucket
aws s3 rm s3://$bucket --recursive

#Delete Bucket
aws s3api delete-bucket \
--bucket $bucket \
--region $region
done

#Delete the template
aws s3 rm s3://$bucketName/\
$(aws s3api list-objects-v2 \
--bucket $bucketName \
| jq -r '.Contents[].Key \
| select(startswith("GameStack"))')



#Delete Cloudwatch LogGroups

loggroups=$(aws logs describe-log-groups \
| jq -r '.logGroups[].logGroupName \
| select(startswith("/aws/lambda/GameStack")),\
select(startswith("API-Gateway-Execution-Logs")),\
select(startswith("/aws/kinesisfirehose/GameStack")),\
select(startswith("/aws/apigateway/welcome"))\
')

for loggroup in $loggroups; do
#echo $loggroup
aws logs delete-log-group \
--log-group-name $loggroup
done

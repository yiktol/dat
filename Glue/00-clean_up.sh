region=$(aws configure get region)
crawlerName=awsglue-datasets
dbName=awsglue-datasets-database
roleName=AWSGlueServiceRoleDefault
policyName=AWSGlueServiceRolePolicy 

#Clean Up
myFileNames=$(ls data)
tables=$(echo $myFileNames | tr '.' '_')

for table in $tables; do
echo "Deleting Glue Table $table"
sleep 1
aws glue delete-table \
--database-name $dbName \
--name $table
done


echo "Deleting Glue DB $dbName"
sleep 2
aws glue delete-database \
--name $dbName

echo "Deleting Glue Crawler $crawlerName"
sleep 2
aws glue delete-crawler \
--name $crawlerName

#Clean Up
echo "Deleting Role Policy $policyName"
sleep 2
aws iam delete-role-policy \
--role-name $roleName \
--policy-name $policyName  

echo "Deleting Role $roleName"
sleep 2
aws iam delete-role \
--role-name $roleName

#Clean Up

buckets=$(aws s3api list-buckets | jq -r '.Buckets[].Name | select(startswith("aws-glue"))')

for bucket in $buckets; do
echo 'Deleting Bucket Objects'
sleep 1
aws s3 rm s3://$bucket --recursive

#Delete Bucket
echo "Deleting Bucket $bucket"
sleep 1
aws s3api delete-bucket \
--bucket $bucket \
--region $region
done

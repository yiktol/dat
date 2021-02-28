iamRole=$(aws iam get-role \
    --role-name AWSGlueServiceRoleDefault \
    --query "Role.Arn" \
    --output text)

aws glue create-crawler \
--name awsglue-datasets \
--role $iamRole \
--database-name awsglue-datasets-database \
--description 'My Glue Crawler' \
--targets S3Targets=[{Path="s3://$bucketname/inventory/"}] 

aws glue start-crawler \
--name awsglue-datasets


#Clean Up
myFileNames=$(ls data)
tables=$(echo $myFileNames | tr '.' '_')

for table in $tables; do
aws glue delete-table \
--database-name awsglue-datasets-database \
--name $table
done

aws glue delete-crawler \
--name awsglue-datasets
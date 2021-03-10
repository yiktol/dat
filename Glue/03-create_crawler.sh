#------------------------------------------------------------------------------
# Create Glue Crawler
#------------------------------------------------------------------------------

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

#Start the Crawler
aws glue start-crawler \
--name awsglue-datasets




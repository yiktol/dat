# Generate a random 8 character lowercase alphanumeric string and numbers in Bash
random-string() {
        cat /dev/urandom | tr -dc 'a-z0-9' | fold -w ${1:-8} | head -n 1
}

randomalpha=$(random-string)
bucketname="emr-bucket-$randomalpha"
region=$(aws configure get region)
clusterName=myEMR

#----------------------------------------------------------------------------------
# Create S3 Bucket
#----------------------------------------------------------------------------------

aws s3api create-bucket \
--bucket $bucketname \
--region $region \
--create-bucket-configuration LocationConstraint=$region


#----------------------------------------------------------------------------------
# Upload Data and Script to S3 Bucket
#----------------------------------------------------------------------------------
file='food_establishment_data.csv'
aws s3api put-object \
--bucket $bucketname \
--key data/$file \
--body data/$file

scipt='health_violations.py'
aws s3api put-object \
--bucket $bucketname \
--key script/$scipt \
--body $scipt


#----------------------------------------------------------------------------------
# Create EMR Cluster
#----------------------------------------------------------------------------------
publicSubnet1=$(aws ec2 describe-subnets \
    --filters Name=tag:Name,Values=msft-pub-1a \
    --query "Subnets[0].SubnetId" \
    --output text)
keyName=$(aws ssm get-parameters \
    --names /et.local/PrivateKey \
    --with-decryption \
    --query "Parameters[*].Value" \
    --output text)


aws emr create-cluster \
--name $clusterName \
--release-label emr-5.32.0 \
--applications Name=Spark \
--ec2-attributes KeyName=$keyName,SubnetId=$publicSubnet1  \
--instance-type m5.xlarge \
--instance-count 2 \
--use-default-roles
						
clusterId=$(aws emr list-clusters --cluster-states WAITING \
--query "Clusters[].Id" \
--output text)
							                        
aws emr describe-cluster \
--cluster-id $clusterId   

#----------------------------------------------------------------------------------
# Submit Work to Amazon EMR
#----------------------------------------------------------------------------------
aws emr add-steps \
--cluster-id $clusterId  \
--steps Type=Spark,Name=$clusterName,ActionOnFailure=CONTINUE,Args=[s3://$bucketname/script/health_violations.py,--data_source,s3://$bucketname/data/food_establishment_data.csv,--output_uri,s3://$bucketname/output]

aws emr describe-step \
--cluster-id $clusterId \
--step-id s-2GIJSO867GK4H

#----------------------------------------------------------------------------------
# Verify Result
#----------------------------------------------------------------------------------

aws s3api get-object \
--bucket $bucketname \
--key output/%filename% output/%filename%

#----------------------------------------------------------------------------------
# Clean Up
#----------------------------------------------------------------------------------                					
#Terminate EMR Cluster
aws emr terminate-clusters \
--cluster-ids $clusterId

aws emr describe-cluster \
--cluster-id $clusterId

#Delete Objects in a Bucket
aws s3 rm s3://$bucketname --recursive

#Delete Bucket
aws s3api delete-bucket \
--bucket $bucketname \
--region $region

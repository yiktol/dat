#------------------------------------------------------------------------------
# Deploy a RedShift Cluster
#------------------------------------------------------------------------------

admin=$(aws ssm get-parameter \
    --name "/redshift/adminUser" \
    --query "Parameter.Value" \
    --output text)
passwd=$(aws ssm get-parameter \
    --name "/redshift/adminPassword" \
    --query "Parameter.Value" \
    --with-decryption \
    --output text)
iamRole=$(aws iam get-role \
    --role-name myRedshiftRole \
    --query "Role.Arn" \
    --output text)
sgId=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values='redshift_sg' \
    --query "SecurityGroups[0].GroupId" \
    --output text)
publicSubnet1=$(aws ec2 describe-subnets \
    --filters Name=tag:Name,Values=msft-pub-1a \
    --query "Subnets[0].SubnetId" \
    --output text)
publicSubnet2=$(aws ec2 describe-subnets \
    --filters Name=tag:Name,Values=msft-pub-1b \
    --query "Subnets[0].SubnetId" \
    --output text)


#Create a DB Subnet Group
aws redshift create-cluster-subnet-group \
--cluster-subnet-group-name mysubnetgroup  \
--description "RedShift Subnet Group" \
--subnet-ids $publicSubnet1 $publicSubnet2 \
--tags Key='Name',Value='redshift_subnet_group'

aws redshift describe-cluster-subnet-groups \
--cluster-subnet-group-name mysubnetgroup

#Create Redshift Cluster
aws redshift create-cluster \
--db-name 'dev' \
--port '5439' \
--node-type 'dc2.large' \
--number-of-nodes 2 \
--master-username $admin \
--master-user-password $passwd \
--iam-roles $iamRole \
--vpc-security-group-ids $sgId \
--cluster-identifier 'mycluster' \
--cluster-subnet-group-name mysubnetgroup


#Clean Up
aws redshift delete-cluster \
--cluster-identifier mycluster \
--skip-final-cluster-snapshot

aws redshift delete-cluster-subnet-group \
--cluster-subnet-group-name mysubnetgroup
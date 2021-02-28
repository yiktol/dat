#------------------------------------------------------------------------------
# Redshift SECURITY GROUP
#------------------------------------------------------------------------------

vpcId=$(aws ec2 describe-vpcs \
--filters Name=tag:Name,Values='MSFT-VPC' \
--query "Vpcs[0].VpcId" \
--output text)

vpcCidr=$(aws ec2 describe-vpcs \
--filters Name=tag:Name,Values='MSFT-VPC' \
--query "Vpcs[0].CidrBlock" \
--output text)

#Create Security group for RedShift
aws ec2 create-security-group \
--group-name Redshift-SG \
--description "Allow Access to Redshift" \
--vpc-id $vpcId \
--tag-specifications "ResourceType=security-group,Tags=[{Key='Name',Value='redshift_sg'}]"

sgId=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values='redshift_sg' \
    --query "SecurityGroups[0].GroupId" \
    --output text)

#Create SG Ingress Rule
aws ec2 authorize-security-group-ingress \
    --group-id $sgId \
    --protocol tcp \
    --port 5439 \
    --cidr $vpcCidr

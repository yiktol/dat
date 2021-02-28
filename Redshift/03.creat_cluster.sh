admin=$(aws ssm get-parameter \
    --name "/redshift/adminUser" \
    --query "Parameter.Value")

passwd=$(aws ssm get-parameter \
    --name "/redshift/adminPassword" \
    --query "Parameter.Value" \
    --with-decryption)

iamRole=$(aws iam get-role \
    --role-name myRedshiftRole \
    --query "Role.Arn" \
    --output text)

sgId=$(aws ec2 describe-security-groups \
    --filters Name=tag:Name,Values='redshift_sg' \
    --query "SecurityGroups[0].GroupId" \
    --output text)

aws redshift create-cluster \
--db-name 'dev' \
--port '5439' \
--node-type 'dc2.large' \
--number-of-nodes 2 \
--master-username $admin \
--master-user-password $passwd \
--iam-roles $iamRole \
--cluster-security-groups $sgId \
--cluster-identifier 'mycluster'
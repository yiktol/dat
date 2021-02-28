#------------------------------------------------------------------------------
# Create IAM Role and Policy
#------------------------------------------------------------------------------

aws iam create-role --role-name AWSGlueServiceRoleDefault \
--assume-role-policy-document file://configs/trust-policy.json

aws iam put-role-policy \
--role-name AWSGlueServiceRoleDefault \
--policy-name AWSGlueServiceRolePolicy \
--policy-document file://configs/policy.json

aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
--role-name AWSGlueServiceRoleDefault

aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole \
--role-name AWSGlueServiceRoleDefault

aws iam get-role \
--role-name AWSGlueServiceRoleDefault


#Clean Up
aws iam detach-role-policy \
--policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
--role-name AWSGlueServiceRoleDefault

aws iam detach-role-policy \
--policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole \
--role-name AWSGlueServiceRoleDefault

aws iam delete-role-policy \
--role-name AWSGlueServiceRoleDefault\
--policy-name AWSGlueServiceRolePolicy   

aws iam delete-role \
--role-name AWSGlueServiceRoleDefault
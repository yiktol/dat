#------------------------------------------------------------------------------
# Create IAM Role and Policy
#------------------------------------------------------------------------------
roleName=AWSGlueServiceRoleDefault
policyName=AWSGlueServiceRolePolicy 


aws iam create-role --role-name $roleName \
--assume-role-policy-document file://configs/trust-policy.json

aws iam put-role-policy \
--role-name $roleName \
--policy-name $policyName \
--policy-document file://configs/firehose-to-s3-policy.json


aws iam get-role \
--role-name $roleName


#Clean Up

aws iam delete-role-policy \
--role-name $roleName\
--policy-name $policyName  

aws iam delete-role \
--role-name $roleName
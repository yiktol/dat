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
--policy-document file://configs/policy.json


#aws iam get-role \
#--role-name $roleName



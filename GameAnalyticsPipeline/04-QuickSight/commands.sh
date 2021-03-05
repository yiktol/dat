#------------------------------------------------------------------------------
# Create IAM Role and Policy
#------------------------------------------------------------------------------
roleName=aws-quicksight-s3-consumers-role-v0
policyName=AWSQuickSightS3Policy
attachPolicy=AWSQuicksightAthenaAccess 


aws iam create-role --role-name $roleName \
--assume-role-policy-document file://trust-policy.json

stackName='GameStack'
analyticsbucket=arn:aws:s3:::$(aws cloudformation describe-stacks \
--stack-name $stackName \
--query "Stacks[0].Outputs[?OutputKey=='AnalyticsBucket'].OutputValue" \
--output text)

sed \
-e "s#%analyticsbucket%#$analyticsbucket#g" ./templates/quicksights3policy.json  > quicksights3policy.json


aws iam put-role-policy \
--role-name $roleName \
--policy-name $policyName \
--policy-document file://quicksights3policy.json


aws iam attach-role-policy \
--policy-arn arn:aws:iam::aws:policy/service-role/$attachPolicy \
--role-name $roleName

aws iam get-role \
--role-name $roleName


#Clean Up

aws iam delete-role-policy \
--role-name $roleName\
--policy-name $policyName  

aws iam delete-role \
--role-name $roleName
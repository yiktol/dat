#------------------------------------------------------------------------------
# Create User and Grant Access to Query editor
#------------------------------------------------------------------------------

user=query_user

aws iam create-user \
--user-name $user

pol1=AmazonRedshiftQueryEditor
pol2=AmazonRedshiftReadOnlyAccess

aws iam attach-user-policy \
--policy-arn arn:aws:iam::aws:policy/$pol1 \
--user-name $user

aws iam attach-user-policy \
--policy-arn arn:aws:iam::aws:policy/$pol2 \
--user-name $user


#Clean up

aws iam detach-user-policy \
--policy-arn arn:aws:iam::aws:policy/$pol1 \
--user-name $user

aws iam detach-user-policy \
--policy-arn arn:aws:iam::aws:policy/$pol2 \
--user-name $user

aws iam delete-user \
--user-name $user
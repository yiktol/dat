aws iam create-role --role-name myRedshiftRole \
--assume-role-policy-document file://templates/trust-policy.json

aws iam put-role-policy \
--role-name myRedshiftRole \
--policy-name RedshiftRolePolicy \
--policy-document file://templates/role-policy.json

aws iam get-role \
    --role-name myRedshiftRole
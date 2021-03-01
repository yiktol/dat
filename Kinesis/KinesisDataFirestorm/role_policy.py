import json
from botocore.exceptions import ClientError
from wrapper.role_wrapper import *

roleName = 'KinesisFirehoseServiceRole'
policyName = 'KinesisFirehoseServicePolicy'
allowed_services = ['firehose.amazonaws.com']

create_role(roleName, allowed_services)

with open('configs/firehose-to-s3-policy.json') as file:
     rolepolicy = json.loads(file.read())

try:
    role_policy = iam.RolePolicy(roleName, policyName)
    response = role_policy.put(PolicyDocument=json.dumps(rolepolicy))
    logger.info("Created policy %s.", policyName)
except ClientError:
    logger.exception("Couldn't create a policy %s.", policyName)
    raise
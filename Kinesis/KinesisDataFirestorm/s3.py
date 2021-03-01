import logging
import string
import random
import boto3
from botocore.exceptions import ClientError

def create_bucket(bucketname, region=None):

    # Create bucket
    try:
        s3_client = boto3.client('s3', region_name=region)
        location = {'LocationConstraint': region}
        s3_client.create_bucket(
            Bucket=bucketname, CreateBucketConfiguration=location)
    except ClientError as e:
        logging.error(e)
        return False
    return check_bucket(bucketname,region)

def check_bucket(bucketname,region=None):
    s3_client = boto3.client('s3', region_name=region)
    response = s3_client.list_buckets()
    for bucket in response['Buckets']:
        if bucket['Name'] == bucketname:
            print(f'  {bucketname} Sucessfully created.')

if __name__ == '__main__':
    bucketname =  'aws-analytics-' + (''.join(random.choices(string.ascii_letters+string.digits,k=8))).lower()
    create_bucket(bucketname, region='ap-southeast-1')

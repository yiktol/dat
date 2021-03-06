#------------------------------------------------------------------------------
# Create S3 Bucket
#------------------------------------------------------------------------------

# Generate a random 8 character lowercase alphanumeric string and numbers in Bash
random-string() {
        cat /dev/urandom | tr -dc 'a-z0-9' | fold -w ${1:-8} | head -n 1
}

randomalpha=$(random-string)
bucketname="mybucket-$randomalpha"
region=$(aws configure get region)

aws s3api create-bucket \
--bucket $bucketname \
--region $region \
--create-bucket-configuration LocationConstraint=$region

#------------------------------------------------------------------------------
# Upload Data to S3 Bucket
#------------------------------------------------------------------------------


myFileNames=$(ls data)

for file in $myFileNames; do
aws s3api put-object \
--bucket $bucketname \
--key tickit/$file \
--body data/$file
done



#Clean Up

#Delete Objects in a Bucket
aws s3 rm s3://$bucketname --recursive

#Delete Bucket
aws s3api delete-bucket \
--bucket $bucketname \
--region $region

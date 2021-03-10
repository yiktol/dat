
#------------------------------------------------------------------------------
# Load Data
#------------------------------------------------------------------------------

#Load Users Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy users from "s3://$bucketname/tickit/allusers_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"

#Load Venue Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy venue from "s3://$bucketname/tickit/venue_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"


#Load Category Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName\
--database $dbName \
--db-user $dbUser \
--sql "copy category from "s3://$bucketname/tickit/category_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"

#Load Date Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy date from "s3://$bucketname/tickit/date2008_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"


#Load Event Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy event from "s3://$bucketname/tickit/allevents_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"


#Load Listing Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy listing from "s3://$bucketname/tickit/listings_pipe.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '|' region "$region";"

#Load Sales Data
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "copy sales from "s3://$bucketname/tickit/sales_tab.txt"
       credentials "aws_iam_role=$iamRole"
       delimiter '\t' timeformat 'MM/DD/YYYY HH:MI:SS' region "$region";"


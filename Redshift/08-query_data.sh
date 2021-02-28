
database='dev'
dbuser='awsuser'

#Get definition for the sales table.
queryId=$(aws redshift-data execute-statement \
--region $region \
--cluster-identifier mycluster \
--database $database \
--db-user $dbuser \
--sql "$(echo `cat ./sql/query1.sql`)" \
--query "Id" \
--output text)

aws redshift-data get-statement-result \
    --id $queryId \
    --region $region \
    --output json

#Find total sales on a given calendar date.    
queryId=$(aws redshift-data execute-statement \
--region $region \
--cluster-identifier mycluster \
--database $database \
--db-user $dbuser  \
--sql "$(echo `cat ./sql/query2.sql`)" \
--query "Id" \
--output text)

aws redshift-data get-statement-result \
    --id $queryId \
    --region $region \
    --output table


#Find top 10 buyers by quantity.    
queryId=$(aws redshift-data execute-statement \
--region $region \
--cluster-identifier mycluster \
--database $database \
--db-user $dbuser  \
--sql "$(echo `cat ./sql/query3.sql`)" \
--query "Id" \
--output text)

aws redshift-data get-statement-result \
    --id $queryId \
    --region $region \
    --output table


#Find events in the 99.9 percentile in terms of all time gross sales.   
queryId=$(aws redshift-data execute-statement \
--region $region \
--cluster-identifier mycluster \
--database $database \
--db-user $dbuser \
--sql "$(echo `cat ./sql/query4.sql`)" \
--query "Id" \
--output text)

aws redshift-data get-statement-result \
    --id $queryId \
    --region $region \
    --output table

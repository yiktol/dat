#------------------------------------------------------------------------------
# Create Tables
#------------------------------------------------------------------------------
#Create Users Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_users.sql`)"

#Create Venue Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName\
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_venue.sql`)"

#Create Category Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_category.sql`)"

#Create Date Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_date.sql`)"

#Create Event Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_event.sql`)"

#Create Listing Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_listing.sql`)"

#Create Sales Table
aws redshift-data execute-statement \
--region $region \
--cluster-identifier $clusterName \
--database $dbName \
--db-user $dbUser \
--sql "$(echo `cat ./sql/table_sales.sql`)"
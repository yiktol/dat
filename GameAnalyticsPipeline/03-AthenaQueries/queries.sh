
aws athena get-work-group \
    --work-group GameAnalyticsWorkgroup-GameStack

aws athena update-work-group \
    --work-group GameAnalyticsWorkgroup-GameStack \
    --state ENABLED

    aws athena update-work-group \
    --work-group primary \
    --state DISABLED
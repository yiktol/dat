
source env/bin/activate

stackName='GameStack'
codepath='/home/ubuntu/DEMO/DAT/GameAnalyticsPipeline/02-GenerateGameEvents/game-analytics-pipeline/source/demo/publish_data.py'

TestApplicationId=$(aws cloudformation describe-stacks \
--stack-name $stackName \
--query "Stacks[0].Outputs[?OutputKey=='TestApplicationId'].OutputValue" \
--output text)

GameEventsStream=$(aws cloudformation describe-stacks \
--stack-name $stackName \
--query "Stacks[0].Outputs[?OutputKey=='GameEventsStream'].OutputValue" \
--output text)

region=$(aws configure get region)

python $codepath \
--region $region \
--stream-name $GameEventsStream \
--application-id $TestApplicationId
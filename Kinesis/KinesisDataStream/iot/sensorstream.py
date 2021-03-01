import json
import datetime
import random
#import testdata
import boto3

kinesis = boto3.client('kinesis', region_name='ap-southeast-1')
# Set a stream name for later
stream_name = 'RawStreamData'

def getData(iotName, lowVal, highVal):
   data = {}
   data["iotName"] = iotName
   data["iotValue"] = random.randint(lowVal, highVal) 
   return data

while 1:
   rnd = random.random()
   if (rnd < 0.01):
      data = json.dumps(getData("DemoSensor", 100, 120))  
      kinesis.put_record(StreamName=stream_name, Data=data, PartitionKey="DemoSensor")
      print('***************************** anomaly ************************* ' + data)
   else:
      data = json.dumps(getData("DemoSensor", 10, 20))  
      kinesis.put_record(StreamName=stream_name, Data=data, PartitionKey="DemoSensor")
      print(data)
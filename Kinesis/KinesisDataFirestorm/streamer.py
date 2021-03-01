import boto3
import json
import random
import time
import uuid

# Set a stream name for later
stream_name = 'sales'
# Create the Kinesis client
kinesis = boto3.client('kinesis', region_name='ap-southeast-1')


def put_to_stream():
    record = {
        'sale_id': str(uuid.uuid4()),
        'timestamp': str(int(time.time())),
        'product_sold': random.choice(
            [
                'socks',
                'jacket',
                'sweatpants',
                'scarf',
                'shirt',
                'pajamas',
                'jeans',
                'raincoat',
            ]
        ),
        'num_items': random.choice([1, 1, 2, 2, 3, 4, 5]),
    }
    print('Sales Id:',record['sale_id'],' Timestamp :',record['timestamp'],' Product:',record['product_sold'],' Numer:',record['num_items'] )
    kinesis.put_record(
        StreamName=stream_name,
        Data=json.dumps(record),
        PartitionKey='a-partition'
    )


# Check that the stream is created before running this
while True:
    put_to_stream()
    time.sleep(.3)

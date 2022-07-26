import json


def lambda_handler(event, context):
    message = 'Hello from Lambda!'
    print(message)
    return {
        'statusCode': 200,
        'body': json.dumps(message)
    }

import os

STAGE = os.environ['STAGE']


def lambda_handler(event, context):
    message = f'Hello from stage {STAGE}'
    print(message)
    return message

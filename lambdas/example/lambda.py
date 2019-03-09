import logging
import os

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

STAGE = os.environ['STAGE']

def lambda_handler(event, context):
    logger.info(event)
    message = f'Hello from stage {STAGE}'
    logger.info(message)
    return message

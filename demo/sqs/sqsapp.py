#!/usr/bin/python
# -*- coding: utf-8 -*-

''' AWS SQS demonstration application
'''

import argparse
import logging
import sys

import boto3

# log to stdout
logger = logging.getLogger('sqsapp')
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler(sys.stdout))


def parse_args(args):
    """ Parse command line parameters
    """

    parser = argparse.ArgumentParser(
            description="Demonstration application for AWS SQS.")

    parser.add_argument(
        'cmd',
        choices=['send-message', 'receive-message', 'status']
    )

    parser.add_argument(
        '--delete',
        dest='delete',
        action='store_true',
        default=False,
        help='Delete SQS message after receipt'
        )

    parser.add_argument(
        '--message',
        dest='message',
        help='SQS message'
        )

    parser.add_argument(
        '--url',
        dest='sqs_url',
        help='AWS SQS URL value',
        required=True
        )

    return parser.parse_args(args)


def main(args):
    args = parse_args(args)

    client = boto3.client('sqs')

    if args.cmd == 'status':
        response = client.get_queue_attributes(
            QueueUrl=args.sqs_url,
            AttributeNames=['All']
        )
        num_messages = response['Attributes']['ApproximateNumberOfMessages']
        not_visible_messages = response['Attributes']['ApproximateNumberOfMessagesNotVisible']
        logger.info(f"Approximate number of messages: {num_messages}")
        logger.info(f"Approximate number of messages not visible: {not_visible_messages}")

    elif args.cmd == 'send-message':
        if args.message:
            response = client.send_message(
                QueueUrl=args.sqs_url,
                MessageBody=args.message
            )
            message_id = response['MessageId']
            logger.info(f"Message ID {message_id} written to the queue.")
        else:
            logger.error('You must specify a message to send to the queue.')

    elif args.cmd == 'receive-message':
        messages = client.receive_message(
            QueueUrl=args.sqs_url,
            MaxNumberOfMessages=1
        )
        if 'Messages' in messages:

            logger.info(messages)

            if args.delete:
                for message in messages['Messages']:
                    response = client.delete_message(
                        QueueUrl=args.sqs_url,
                        ReceiptHandle=message['ReceiptHandle']
                    )
                    logger.info(f"Deleted message: {message['MessageId']}")
        else:
            logger.info('No messages found in queue.')


if __name__ == "__main__":
    main(sys.argv[1:])

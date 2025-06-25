#pylint: skip-file
import json
import boto3
import os

sqs = boto3.client('sqs')

# Nome ou URL da fila de destino (configure via variável de ambiente)
TARGET_QUEUE_URL = os.environ['TARGET_QUEUE_URL']

def lambda_handler(event, context):
    for record in event['Records']:
        body = record['body']
        print(f"Recebido: {body}")

        # Envia para a fila de destino
        try:
            response = sqs.send_message(
                QueueUrl=TARGET_QUEUE_URL,
                MessageBody=body
            )
            print(f"Mensagem enviada para a fila de destino: {response['MessageId']}")
        except Exception as e:
            print(f"Erro ao enviar mensagem: {str(e)}")

    return {
        'statusCode': 200,
        'body': json.dumps('Mensagens processadas com sucesso!')
    }

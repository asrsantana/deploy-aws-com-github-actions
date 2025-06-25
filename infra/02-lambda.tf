resource "aws_lambda_function" "lambda_processa_mensagem" {
  function_name = "processa_mensagem"
  role          = aws_iam_role.lambda_processa_mensagem.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"
  filename      = "zip_files/lambda.zip"
  timeout       = 30

  source_code_hash = filebase64sha256("zip_files/lambda.zip")

  environment {
    variables = {
      TARGET_QUEUE_URL = aws_sqs_queue.recebe_mensagem.url
    }
  }
  depends_on = [aws_iam_role.lambda_processa_mensagem]
}

resource "aws_lambda_event_source_mapping" "trigger_sql" {
  event_source_arn = aws_sqs_queue.envia_mensagem.arn
  function_name    = aws_lambda_function.lambda_processa_mensagem.arn
  batch_size       = 10
  enabled          = true
}

resource "aws_iam_role" "lambda_processa_mensagem" {
  name = "lambda_processa_mensagem_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })  
}

resource "aws_iam_role_policy" "lambda_processa_mensagem_policy" {
  name = "lambda_processa_mensagem_policy"
  role = aws_iam_role.lambda_processa_mensagem.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes", 
        ]
        Effect   = "Allow"
        Resource = [
          aws_sqs_queue.recebe_mensagem.arn,
          aws_sqs_queue.envia_mensagem.arn
        ]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_sqs_queue" "envia_mensagem" {
  name                      = "envia-mensagem"
  visibility_timeout_seconds = 30
  message_retention_seconds = 86400 # 1 day
  delay_seconds             = 0

  tags = {
    Name        = "envia-mensagem"
    Environment = "dev"
  }  
}

resource "aws_sqs_queue" "recebe_mensagem" {
  name                      = "recebe-mensagem"
  visibility_timeout_seconds = 30
  message_retention_seconds = 86400 # 1 day
  delay_seconds             = 0

  tags = {
    Name        = "recebe-mensagem"
    Environment = "dev"
  }  
}
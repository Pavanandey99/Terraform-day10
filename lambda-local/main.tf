resource "aws_lambda_function" "my_lambda" {
    function_name = "my_lambda_function"
    role = aws_iam_role.lambda_role.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.12"
    timeout = 900
    memory_size = 128

    filename = "lambda_function.zip"  
    source_code_hash = filebase64sha256("lambda_function.zip")  
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
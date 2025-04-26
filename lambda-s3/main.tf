resource "aws_s3_bucket" "S3-Lambda" {
  bucket = "s3lambda27042025"
  force_destroy = true

  tags = {
    Name = "S3-Lambda"
  }
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.S3-Lambda.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip" 
  etag   = filemd5("lambda_function.zip")
}


resource "aws_iam_role" "s3-lambda" {
  name = "s3-lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.s3-lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.9"
  role             = aws_iam_role.s3-lambda.arn
  handler          = "lambda_function.lambda_handler" 
  s3_bucket        = aws_s3_bucket.S3-Lambda.id 
  s3_key           = aws_s3_object.lambda_code.key 
  timeout          = 900
  memory_size      = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example environment variable
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}
# Serverless Application based on AWS Lambda and API Gateway

## API Gateway

### Introduction

> Amazon API Gateway is an AWS service for creating, publishing, maintaining, monitoring, and securing REST, HTTP, and WebSocket APIs at any scale.

+ [API Integration types](Gateway API integration)
  + AWS
  + AWS_PROXY
  + HTTP
  + HTTP_PROXY
  + MOCK

### Integrations

__*The first important thing we need to know is the different version of response format and request event.*__

+ Request Event (1.0 vs 2.0)

  + Version 1.0

    ```json
    {
      "version": "1.0",
      "resource": "/my/path",
      "path": "/my/path",
      "httpMethod": "GET",
      "headers": {
        "header1": "value1",
        "header2": "value2"
      },
      "multiValueHeaders": {
        "header1": [
          "value1"
        ],
        "header2": [
          "value1",
          "value2"
        ]
      },
      "queryStringParameters": {
        "parameter1": "value1",
        "parameter2": "value"
      },
      "multiValueQueryStringParameters": {
        "parameter1": [
          "value1",
          "value2"
        ],
        "parameter2": [
          "value"
        ]
      },
      "requestContext": {
        "accountId": "123456789012",
        "apiId": "id",
        "authorizer": {
          "claims": null,
          "scopes": null
        },
        "domainName": "id.execute-api.us-east-1.amazonaws.com",
        "domainPrefix": "id",
        "extendedRequestId": "request-id",
        "httpMethod": "GET",
        "identity": {
          "accessKey": null,
          "accountId": null,
          "caller": null,
          "cognitoAuthenticationProvider": null,
          "cognitoAuthenticationType": null,
          "cognitoIdentityId": null,
          "cognitoIdentityPoolId": null,
          "principalOrgId": null,
          "sourceIp": "IP",
          "user": null,
          "userAgent": "user-agent",
          "userArn": null,
          "clientCert": {
            "clientCertPem": "CERT_CONTENT",
            "subjectDN": "www.example.com",
            "issuerDN": "Example issuer",
            "serialNumber": "a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1",
            "validity": {
              "notBefore": "May 28 12:30:02 2019 GMT",
              "notAfter": "Aug  5 09:36:04 2021 GMT"
            }
          }
        },
        "path": "/my/path",
        "protocol": "HTTP/1.1",
        "requestId": "id=",
        "requestTime": "04/Mar/2020:19:15:17 +0000",
        "requestTimeEpoch": 1583349317135,
        "resourceId": null,
        "resourcePath": "/my/path",
        "stage": "$default"
      },
      "pathParameters": null,
      "stageVariables": null,
      "body": "Hello from Lambda!",
      "isBase64Encoded": false
    }
    ```

  + Version 2.0

    ```json
    {
      "version": "2.0",
      "routeKey": "$default",
      "rawPath": "/my/path",
      "rawQueryString": "parameter1=value1&parameter1=value2&parameter2=value",
      "cookies": [
        "cookie1",
        "cookie2"
      ],
      "headers": {
        "header1": "value1",
        "header2": "value1,value2"
      },
      "queryStringParameters": {
        "parameter1": "value1,value2",
        "parameter2": "value"
      },
      "requestContext": {
        "accountId": "123456789012",
        "apiId": "api-id",
        "authentication": {
          "clientCert": {
            "clientCertPem": "CERT_CONTENT",
            "subjectDN": "www.example.com",
            "issuerDN": "Example issuer",
            "serialNumber": "a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1",
            "validity": {
              "notBefore": "May 28 12:30:02 2019 GMT",
              "notAfter": "Aug  5 09:36:04 2021 GMT"
            }
          }
        },
        "authorizer": {
          "jwt": {
            "claims": {
              "claim1": "value1",
              "claim2": "value2"
            },
            "scopes": [
              "scope1",
              "scope2"
            ]
          }
        },
        "domainName": "id.execute-api.us-east-1.amazonaws.com",
        "domainPrefix": "id",
        "http": {
          "method": "POST",
          "path": "/my/path",
          "protocol": "HTTP/1.1",
          "sourceIp": "IP",
          "userAgent": "agent"
        },
        "requestId": "id",
        "routeKey": "$default",
        "stage": "$default",
        "time": "12/Mar/2020:19:03:58 +0000",
        "timeEpoch": 1583348638390
      },
      "body": "Hello from Lambda",
      "pathParameters": {
        "parameter1": "value1"
      },
      "isBase64Encoded": false,
      "stageVariables": {
        "stageVariable1": "value1",
        "stageVariable2": "value2"
      }
    }
    ```

  + Notes

    __*When we want to perform different logical processing according to the request endpoint path, the first version parameter is `path`, and the second version parameter is `rawPath`*__, and you need be careful about this.

+ The format of response

  + Verson 1.0

    ```json
    {
        "isBase64Encoded": true|false,
        "statusCode": httpStatusCode,
        "headers": { "headername": "headervalue", ... },
        "multiValueHeaders": { "headername": ["headervalue", "headervalue2", ...], ... },
        "body": "..."
    }
    ```

  + Version 2.0

    ```json
    {
        "cookies" : ["cookie1", "cookie2"], 		 		// not required
        "isBase64Encoded": true|false,  					// not required
        "statusCode": httpStatusCode,  						// not required
        "headers": { "headername": "headervalue", ... }, 	// not required
        "body": "Hello from Lambda!"
    }      
    ```

  + Note

    __*When the version number is 1.0, the returned response must include all the above fields, and if we not return all of them, the API Gateway will throw an error about the invalid response format. And when the version number is 2.0, we only need to return the `body` field, the rest of the fields are only optional, and API Gateway can automatically infer and help us complete*__

    

## Lambda

## Terraform

### Steps

+ initialization: Initialize the terraform environment

  ```shell
  terraform init
  ```
+ Validation: Check the syntax error

  ```shell
  terraform validation
  ```
+ Plan: check the deploy plan

  ```shell
  terraform plan
  ```
+ Apply: deploy the infrastructure

  ```shell
  terraform apply
  ```
+ Destroy: Delete all the infrastructure

  ```shell
  terraform destroy
  ```

### Resource

The resources we need are listed below.

+ API Gateway

  We need a API Gateway to deal with the request. And We must config the integration and route.

+ Lambda

  We need a Lambda Handler to process the request event from the API Gateway.

+ S3

  We need a Bucket to store the code of the Lambda Function.

### Tips

You must provide your AWS key and secret, and give the value in the `terraform.tfvars` as below:

```shell
# provider
aws_region = "us-east-1"
aws_access_key = "xxxxxx"
aws_secret_key = "xxxxxx"
```
When the infrastructure build successfully, you will see the output as below.

```shell
Apply complete! Resources: 18 added, 0 changed, 0 destroyed.

Outputs:

api_gateway_endpoint = "https://xxxxxx.execute-api.us-east-1.amazonaws.com/serverless_lambda_stage"
function_name = "api-backend-demo"
lambda_function_name = "api-backend-demo"
s3_bucket_name = "demo-gradually-friendly-apt-monster"
```

## Github Action

We use the github action workflow to automate the deployment of code to the cloud. __*You can check and view the github action configuration in the folder of ".github" in this Repo*__

### Workflow

The workflow as below:

+ CI
  + Checkout the Code to the github runner
  + Lint the code, you can run flake8 or other tools to check the code format.
  + Run the unittest, you can use tox, pytets, unittest or some tools to implement the unit test of the code.
+ CD
  + Checkout the Code to the github runner
  + Configure AWS credentials
  + Generate zip package
  + Upload the zip file to S3.
  + Update Lambda Function Code

### Tips

1. You need to add your secret key in the Repo.(Click settings of the Repo you will find the place to add secret key)
2. We use Terraform build and run the minimum usable program, so the in the CI jobs, we just need to update the lambda handler code and update the file to AWS S3, then update the lambda function code.
3. You must update the `env` parameters in the `.github.yml` file.

### Display

+ Get the Person Resource

![image-20220705183154216](E:\GitTonyStark\Serverless-API-based-on-AWS-PaaS-Private\img\image-20220705183154216.png)

+ Create the Person Resource

![image-20220705182611326](E:\GitTonyStark\Serverless-API-based-on-AWS-PaaS-Private\img\image-20220705182611326.png)

## Reference

+ [ Amazon API Gateway official document](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
+ [Working with AWS Lambda proxy integrations for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.v2)
+ [Handling API Gateway common errors](https://dashbird.io/blog/resolve-all-api-gateway-errors/)
+ [Github Action Environment variables](https://docs.github.com/en/enterprise-cloud@latest/actions/learn-github-actions/environment-variables)


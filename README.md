# secret-management

This repository manages secrets on the AWS Parameter Store, and is intended to serve across different apps.

## Prerequisites

- Terraform

## The Idea

We use local json to store credentials, and provision them to AWS SSM Parameter Store. The path used for SSM parameter naming, is consistent with the path of local json secret files. The path entitles namespace for each credential, so that collision is not likely to occur.

### Adding credential

First decide a path to store the credential, e.g., if the credential is for an app, then store the credential in the corresponding json file. 

Then, when adding an entry in json, use the path plus the credential name as the key, then specify the value:

```json
{
    ...
    "/service/gmail/EMAIL_HOST_PASSWORD": "password here",
    ...
}
```

### Accessing credential from other app

You will use terraform to read the parameters first.

```terraform
data "aws_ssm_parameter" "app_credentials" {
  name  = "/service/gmail/EMAIL_HOST_PASSWORD"
}
```

Then you can access the secret value by `data.aws_ssm_parameter.app_credentials.value`.

### Server as environment variables in K8 apps

It is a convention to use the last token of SSM parameter name as the environment variable name inside the app container. e.g., if using SSM parameter `/service/gmail/EMAIL_HOST_PASSWORD`, use `EMAIL_HOST_PASSWORD` as the environment name when passing in the contaienr. This is usually done in a Kubernetes Deployment.
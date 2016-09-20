An example of AWS Lambda in Python with libraries.
==================================================

Requirements
------------

* Python 2.7
* [AWS CLI](https://aws.amazon.com/cli/)
* AWS account and a config with credentials in `~/.aws/config`, e.g.:

```cfg
[profile user]
aws_access_key_id = asdf
aws_secret_access_key = qwer
region = eu-central-1
```

Tasks
-----

See Makefile for more details.

* `install` - install dependencies, virtual env. etc.
* `firstdeploy` - creates a new lambda called `wget_py`
* `deploy` - updates a lambda function

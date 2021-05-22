#!/bin/bash

STACK_NAME=IAM-Enforce-MFA
REGION=us-east-1
ADMINS_GROUP_NAME=Admins
POWER_USERS_GROUP_NAME=PowerUsers


echo "Validating template"
aws cloudformation validate-template --region ${REGION} --template-body file://enforce-mfa-cf-template.yml
echo "Template validated"


echo "Deploying '${STACK_NAME}' stack with following AWS identity:"
aws sts get-caller-identity
read -r -p "Press Enter to proceed, Ctrl+C to cancel. "

echo "Creating stack"
aws cloudformation create-stack --region ${REGION} --stack-name "${STACK_NAME}" --enable-termination-protection --template-body file://enforce-mfa-cf-template.yml --parameters ParameterKey=AdminsGroupName,ParameterValue=${ADMINS_GROUP_NAME} --parameters ParameterKey=PowerUsersGroupName,ParameterValue=${POWER_USERS_GROUP_NAME} --capabilities CAPABILITY_NAMED_IAM
echo "Stack created"

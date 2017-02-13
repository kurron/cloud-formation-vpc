#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X}
PROJECTNAME=${2:-Weapon-X}
NETWORK=${3:-10.0.0.0}
ENVIRONMENT=${4:-development}
CREATOR=${5:-CloudFormation}
TEMPLATELOCATION=${6:-file://$(pwd)/vpc.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME \
                                        --template-body $TEMPLATELOCATION \
                                        --capabilities CAPABILITY_NAMED_IAM \
                                        --parameters ParameterKey=Project,ParameterValue=$PROJECTNAME \
                                                     ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
                                                     ParameterKey=Creator,ParameterValue=$CREATOR \
                                                     ParameterKey=Network,ParameterValue=$NETWORK \
                                        --tags Key=Project,Value=$PROJECTNAME \
                                               Key=Environment,Value=$ENVIRONMENT \
                                               Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE

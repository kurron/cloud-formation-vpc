#!/bin/bash

# creates a stack in AWS via CloudFromation

STACKNAME=${1:-Weapon-X}
PROJECTNAME=${2:-Weapon-X}
ENVIRONMENT=${3:-development}
CREATOR=${4:-CloudFormation}
TEMPLATELOCATION=${5:-file://$(pwd)/vpc.yml}

VALIDATE="aws cloudformation validate-template --template-body $TEMPLATELOCATION"
echo $VALIDATE
$VALIDATE

CREATE="aws cloudformation create-stack --stack-name $STACKNAME --template-body $TEMPLATELOCATION --tags Key=Project,Value=$PROJECTNAME Key=Environment,Value=$ENVIRONMENT Key=Creator,Value=$CREATOR"
echo $CREATE
$CREATE

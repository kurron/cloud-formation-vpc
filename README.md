# Overview
This project is a [CloudFormation](https://aws.amazon.com/cloudformation/) template
that creates a new VPC from scratch.  The template tries to incorporate best
practices, including multi-az public and private subnets.  It also uses a consistent
tagging strategy so reports can easily be run to track costs.

## Assets Produced
1. New VPC (10.0.0.0/16)
1. Public subnets in two availability zones (10.0.10.0/24 and 10.0.30.0/24)
1. Private subnets in two availability zones (10.0.20.0/24 and 10.0.40.0/24)
1. Internet Gateway
1. NAT Gateways (one in each availability zone)
1. Elastic IPs (each NAT Gateway requires one)
1. Bastion Servers (one in each availability zone)
1. Security Group that only allows SSH access
1. Security Group that only allows access from instances using the Bastion boxes
1. Security Group that allows unrestricted access (meant for troubleshooting only)

## Tagging Strategy
The following tags are applied to assets that allow tagging:
* Project - useful for generating cost reports, defaults to `Weapon-X`
* Purpose - what role the asset plays in the VPC, eg `Bastion Server`
* Creator - the entity creating the assets, defaults to `CloudFormation`
* Environment - the context the assets are a part of, defaults to `development`
* Freetext - place holder for asset-specific notes, meant to be adjusted in the console if needed

# Prerequisites
* a working [AW CLI](https://aws.amazon.com/cli/)
* you have run `aws configure`, providing the required information

# Building
There is noting to build.

# Installation
There is nothing to install.

# Tips and Tricks

## Creating The Stack
There is a convenience Bash script that can be run to create a new VPC.  If
you just want to test things out run `scripts/create-stack.sh`.  In several
moments, your VPC should be created.  Check your AWS console for confirmation.

If you want to specify certain aspects of the VPC, try running something like this:
`scripts/create-stack.sh production-vpc Phoenix production you@somewhere.com`.
This form provides the following:
* stack name of `production-vpc`
* project name of `Phoenix`
* environment name of `production`
* creator of `you@somewhere.com`


## Destroying The Stack
There is a convenience script for destroying VPCs.  run
`scripts/destroy-stack.sh production-vpc` to destroy the VPC we created above.

## Creation Via The Console
TODO: need to talk about getting the `vpc.yml` file into S3 so tha the console can see it

# Troubleshooting

## Elastic IPs
By default, your account is only allowed 5 EIPs.  If you use this template and
build multiple VPCs, you'll have to petition Amazon and get them to raise your
limit.

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

#!/usr/bin/env bash

source ./change_ec2_instance_type.sh

read -p "Enter the instance ID: " instance_id
read -p "Enter the new instance type: " instance_type

change_ec2_instance_type -i $instance_id -t $instance_type -r
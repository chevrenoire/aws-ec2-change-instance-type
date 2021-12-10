# Change Amazon EC2 Instance Type

The heavy portion of this was lifted directly from [awsdocs/aws-doc-sdk-examples](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/aws-cli/bash-linux/ec2). However, I have modified the `test` and `change` scripts to fit my needs.

## Files
  * `change_ec2_instance_type.sh` - main script example file
  * `test_change_ec2_instance_type.sh` - unit/integration test file
  * `general.sh` - common test support function file
  * `run_resize.sh` - simple run script for input-guided resizing

## Changes

The supplied scripts make assumptions around the user working with a singular AWS account and credentials file, within a single (or perhaps assumed) region, and within the default VPC. Also, the change script used a hard-coded instance type.

In my case, none of this applied.

I updated the scripts to include `read -p` command line input variables for `AWS_PROFILE`, `AWS_REGION`, `INSTANCE_TYPE`, and for testing, a `SUBNET_ID`.


## Running the code

It's a good idea to run the tests first to ensure everything is wired up properly, and to avoid any _unhappy_ accidents in your actual environment. **NOTE**: the "`test`" script actually creates and destroys infrastructure in your AWS account.

### Testing

You'll need to uncomment `line 52` if you use VPC's outside of the _default_.

```bash
#read -p "Enter the subnet ID to use: " SUBNET_ID
```

Run the test:
```bash
$ bash test_change_ec2_instance_type.sh -v
$ Enter the AWS profile to use: NAME_OF_PROFILE
$ Enter the region to use: REGION
$ Enter the subnet ID to use: SUBNET_ID
```
You'll be prompted on the command line to input the profile, region, and subnet.

Check the source repo for additional flags.

**NOTE:** I use `zsh` so I run the script with `bash`, I found that simply running the script with `./script.sh` would throw errors.

### Run a live EC2 change

If you uncommented `line 52` in the `test` script, you'll need to comment it again.

Then, simply run the `run_resize.sh` script:
```bash
$ bash run_resize.sh
$ Enter the AWS profile to use: NAME_OF_PROFILE
$ Enter the region to use: REGION
$ Enter the instance ID: INSTANCE_ID
$ Enter the instance type: INSTANCE_TYPE

The instance $INSTANCE_ID is currently running. It must be stopped to change the type.
ARE YOU SURE YOU WANT TO STOP THE INSTANCE? (Y or N) Y
```

That's it. You can follow along in the AWS Console where you'll see the instance stop, change types, and start again.

## Would be nice

* Get this to accept a file of instance id's and iterate the change across them


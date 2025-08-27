# terraform
for terraform studies
CloudFormation SNS Notifications for Stack Events

Prereqs
- AWS CLI v2 configured with appropriate credentials and region
- S3 bucket to host templates (example: s3://my-cfn-artifacts)

Files
- network.yaml: child template creating VPC, subnets, IGW, NAT, routes, SG
- parent-with-sns.yaml: parent template creating SNS topic + nested stack

Upload child template to S3
```bash
aws s3 cp /workspace/network.yaml s3://my-cfn-artifacts/network.yaml
```

Create parent stack with email notifications
```bash
aws cloudformation create-stack \
  --stack-name xyz-parent-sns \
  --template-body file:///workspace/parent-with-sns.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters \
      ParameterKey=EmailAddress,ParameterValue=you@example.com \
      ParameterKey=ChildTemplateUrl,ParameterValue=https://s3.amazonaws.com/my-cfn-artifacts/network.yaml \
      ParameterKey=VpcCidr,ParameterValue=10.0.0.0/16 \
      ParameterKey=PublicSubnetCidrs,ParameterValue=10.0.10.0/24,10.0.20.0/24 \
      ParameterKey=PrivateSubnetCidrs,ParameterValue=10.0.30.0/24,10.0.40.0/24 \
      ParameterKey=AvailabilityZones,ParameterValue=us-east-1a,us-east-1b
```

Confirm SNS subscription
- Check your inbox for a confirmation email from AWS Notifications and confirm.
- After confirming, you will receive emails for every nested stack event during create/update/delete.

Update stack
```bash
aws cloudformation update-stack \
  --stack-name xyz-parent-sns \
  --template-body file:///workspace/parent-with-sns.yaml \
  --parameters \
      ParameterKey=EmailAddress,UsePreviousValue=true \
      ParameterKey=ChildTemplateUrl,UsePreviousValue=true \
      ParameterKey=VpcCidr,UsePreviousValue=true \
      ParameterKey=PublicSubnetCidrs,UsePreviousValue=true \
      ParameterKey=PrivateSubnetCidrs,UsePreviousValue=true \
      ParameterKey=AvailabilityZones,UsePreviousValue=true
```

Delete stack
```bash
aws cloudformation delete-stack --stack-name xyz-parent-sns
```

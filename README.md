This repo provide a terraform code to extend an existing Aviatrix transit gateway with external BGPoIPSec connection to remote. 

It utilizes "aviatrix_transit_gateway" data source and build a "aviatrix_transit_external_device_conn" resource.

A simple tfvars can be used for deploy the external BGPoIPSec connection
```
gw_name             = "transit_gw_name"
pri_remote_gw_ip    = "123.123.123.123"
bkp_remote_gw_ip    = "124.124.124.124"
remote_asn          = 65100
```
Save the above variables and values as testing.tfvars file and pass it to plan and apply
```
terraform init
terraform plan -var-file=testing.tfvars
terraform apply -var-file=testing.tfvars
```
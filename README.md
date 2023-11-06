# terraform_ec2_eip
This terraform code will create an ec2 VM and assign elastic ip. (should be run first VM code than EIP code).
Destroying the resources from VM will not destroy the EIP , that means that if u change the ami image/OS the IP will be the same if you re-run VM terraform code, but after that u need to re-apply the EIP terraform code.

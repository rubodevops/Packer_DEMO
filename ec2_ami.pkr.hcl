// To make Packer read these variables from the environment into the var object,
// set the environment variables to have the same name as the declared
// variables, with the prefix PKR_VAR_.

// There are other ways to [set variables](/docs/templates/hcl_templates/variables#assigning-values-to-build-variables)
// including from a var file or as a command argument.

// export PKR_VAR_aws_access_key=$YOURKEY
variable "aws_access_key" {
  type = string
  // default = "hardcoded_key"
}

// export PKR_VAR_aws_secret_key=$YOURSECRETKEY
variable "aws_secret_key" {
  type = string
  // default = "hardcoded_secret_key"
}

source "amazon-ebs" "basic-example" {
  access_key = var.aws_access_key
  secret_key =  var.aws_secret_key
  region =  "us-east-2"
  source_ami =  "ami-00399ec92321828f5"
  instance_type =  "t2.micro"
  ssh_username =  "ubuntu"
  ami_name =  "packer_AWS_{{timestamp}}"
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]

   provisioner "ansible" {
      playbook_file = "./playbook.yml"
  }

}
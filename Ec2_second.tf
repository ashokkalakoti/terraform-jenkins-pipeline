resource "aws_instance" "cicd_infra_test" {
  ami                   = "ami-0ae3e6717dc99c62b"
  instance_type         = "m5.xlarge"
  subnet_id             = "subnet-097ce800c64d29b91"
 vpc_security_group_ids        = [ "sg-06f13c8befd2f75e5" ]
 iam_instance_profile   = "SSMROLEFOREC2"
 key_name               = "Ec2-Key"
 user_data = "${file("install_dokku.sh")}"
 root_block_device {
   volume_size          = 10
   #volume_type          = "gp2"
   delete_on_termination = true
 }  


  tags = {
    Name = "cicd_infra_test"
  }
}


output "Second_Ec2_public_ip" {
  value = "${aws_instance.cicd_infra_test.public_ip}"
}

output "Second_Ec2_private_ip" {
  value = "${aws_instance.cicd_infra_test.private_dns}"
}
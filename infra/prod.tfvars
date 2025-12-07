Environments = "prod"
bastion_key_name = "prod_bastion_key_name"
bastion_public_key = "prod_bastion_public_key"
bastion_sg_name = "prod/bastion-sg-group"
bastion_ports = [22]
bastion_instance_type = "t2.nano"
bastion_ebs_volume = 8
var.ami = "ami-02b8269d5e85954ef"

# Jenkins Server configuration
# jenkins_key_name = "jenkins_key"
# jenkins_public_key = "jenkins_key.pub"
# jenkins_ports = [ 22,80,8080 ]
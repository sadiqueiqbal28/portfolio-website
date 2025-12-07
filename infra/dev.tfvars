Environments = "dev"

# Bastion Server Variables
bastion_key_name = "bastion"
bastion_public_key = "bastion.pub"
bastion_sg_name = "dev/bastion-sec-group"
bastion_ports = [22]
bastion_instance_type = "t2.nano"
bastion_ebs_volume = 8
ami = "ami-02b8269d5e85954ef"

# Jenkins Server configuration
jenkins_key_name = "jenkins"
jenkins_public_key = "jenkins.pub"
jenkins_ports = [ 22,80,8080 ]
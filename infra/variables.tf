# Environments
variable "Environments" {
  default = "env"
  type = string
}



# --------------------Bastion Server Configuration---------------------------

# Bation Key Name & Public Key
variable "bastion_key_name" {
  default = "bastion_key"
  type = string
}

# Bastion Public Key
variable "bastion_public_key" {
  default = "bastion_key.pub"
  type = string
}

# Bastion Security Group
variable "bastion_sg_name" {
  default = "Bastion-Security-Group"
  type = string
}

# Bastion Security Group Ports
variable "bastion_ports" {
  default = [22]
  type    = list(number)
}

# Bastion Instance Type
variable "bastion_instance_type" {
  default = "t2.nano"
  type = string
}

# Bastion EBS Volume Size
variable "bastion_ebs_volume" {
  default = 8
  type = number
}




# -----------------------AMI of Instance----------------------------------

variable "ami" {
  default = "ami-02b8269d5e85954ef"
  type    = string
}



# -----------------Jenkins Server Configuration--------------------------------

# Jenkins Security Group Ports
variable "jenkins_ports" {
  default = [22, 8080, 80]
  type    = list(number)
}

# Jenkins Key Name
variable "jenkins_key_name" {
  default = "jenkins_key"
  type = string
}

# Jenkins Public Key
variable "jenkins_public_key" {
  default = "jenkins_key.pub"
  type = string 
}
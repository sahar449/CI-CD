variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = ""
}

variable "subnet" {
  type = list(string)
  default = ["172.20.0.0/16", "172.20.10.0/24"]
}

variable "ports" {
  type = list(number)
  default = [22,80,443,8080,8081]
}

variable "ami" {
  default = "ami-0022f774911c1d690"
}

variable "instance_type" {
  type = list(string)
  default = ["t2.micro","t2.medium"]
}
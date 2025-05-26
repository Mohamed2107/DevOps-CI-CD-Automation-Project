variable "type" {
    default = "t3.medium"
  
}
variable "ami" {
    default = "ami-084568db4383264d4"
  
}
variable "subnet_id" {
    default = ""
  
}
variable "security_group" {
     type    = list(string)
     default = ["sg-08f83f0ab1ceda63c"]
  
}
variable "public_ip" {
    default = true
  
}
variable "key" {

  
}
variable "tag" {
  
}
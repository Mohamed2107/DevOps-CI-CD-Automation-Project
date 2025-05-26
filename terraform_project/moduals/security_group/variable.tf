variable "port" {
    type = list(string)
    default = ["80","22"]
}
variable "type" {
    type = list(string)
    default = ["tcp","tcp"]

}
variable "vpc_id" {
    default = ""
  
}

variable "tag" {
  
}

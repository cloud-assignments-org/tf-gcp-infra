
variable "private_service_name" {
    type = string
    description = "The name of the private service"
}  

variable "private_service_purpose" {
    type = string
    description = "The purpose of the resource. Possible values include: VPC_PEERING - for peer networks, PRIVATE_SERVICE_CONNECT - for (Beta only) Private Service Connect networks"
}  

variable "private_service_address_type" {
    type = string
    description = "The type of the address to reserve: EXTERNAL indicates public/external single IP address., INTERNAL indicates internal IP ranges belonging to some network. Default value: \"EXTERNAL\" Possible values: [\"EXTERNAL\", \"INTERNAL\"]"
}  

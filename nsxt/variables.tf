variable "nsxt_host" {
  description = "The NSX-T host. Must resolve to a reachable IP address, e.g. `nsxmgr.example.tld`"
  type        = string
}

variable "nsxt_username" {
  description = "The NSX-T username, probably `admin`"
  type        = string
}

variable "nsxt_password" {
  description = "The NSX-T password"
  type        = string
}

variable "nsxt_ca_cert" {
  type    = string
}

variable "allow_unverified_ssl" {
  default     = false
  description = "Allow connection to NSX-T manager with self-signed certificates. Set to `true` for POC or development environments"
  type        = string
}

variable "environment_name" {
  description = "An identifier used to tag resources; examples: `dev`, `EMEA`, `prod`"
  type        = string
}

variable "east_west_transport_zone_name" {
  description = "The name of the Transport Zone that carries internal traffic between the NSX-T components. Also known as the `overlay` transport zone"
  type        = string
}

variable "external_ip_pool_cidr" {
  description = "The CIDR for the External IP Pool. Must be reachable from clients outside the foundation. Can be RFC1918 addresses (10.x, 172.16-31.x, 192.168.x), e.g. `10.195.74.0/24`"
  type        = string
}

variable "external_ip_pool_ranges" {
  description = "The IP Ranges for the External IP Pool. Each PAS Org will draw an IP address from this pool; make sure you have enough, e.g. `[\"10.195.74.128-10.195.74.250\"]`"
  type        = list(string)
}

variable "external_ip_pool_gateway" {
  description = "The gateway for the External IP Pool, e.g. `10.195.74.1`"
  type        = string
}

variable "nsxt_edge_cluster_name" {
  description = "The name of the deployed Edge Cluster, e.g. `edge-cluster-1`"
  type        = string
}

variable "nsxt_t0_router_name" {
  default     = "T0-Router"
  description = "The name of the T0 router"
  type        = string
}

variable "nat_gateway_ip" {
  description = "The IP Address of the SNAT rule for egress traffic from the Infra & Deployment subnets; should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.17`"
  type        = string
}

variable "ops_manager_public_ip" {
  description = "The public IP Address of the Operations Manager. The om's DNS (e.g. `om.system.tld`) should resolve to this IP, e.g. `10.195.74.16`"
  type        = string
}

variable "nsxt_lb_web_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for Web (HTTP(S)) traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.17`"
  type        = string
}

variable "nsxt_lb_tcp_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for TCP traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.19`"
  type        = string
}

variable "nsxt_lb_tcp_virtual_server_ports" {
  description = "The list of port(s) on which the Virtual Server listens for TCP traffic, e.g. `[\"8080\", \"52135\", \"34000-35000\"]`"
  type        = list(string)
}

variable "nsxt_lb_ssh_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for SSH traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.18`"
  type        = string
}

variable "vcenter_datacenter" {
  type = string
}

variable "vcenter_datastore" {
  type = string
}

variable "vcenter_host" {
  type = string
}

variable "vcenter_username" {
  type = string
}

variable "vcenter_password" {
  type = string
}

variable "vcenter_resource_pool" {
  type = string
}

variable "vcenter_cluster" {
  type = string
}

variable "ops_manager_ntp" {
  type = string
}

variable "ops_manager_netmask" {
  type = string
}

variable "ops_manager_dns" {
  type = string
}

variable "ops_manager_dns_servers" {
  type = string
}

variable "ops_manager_folder" {
  type = string
  default = ""
}

variable "subnet_prefix" {
  type = string
  default = "192.168"
}

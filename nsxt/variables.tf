# General {
variable "nsxt_host" {
  description = "The NSX-T host. Must resolve to a reachable IP address, e.g. `nsxmgr.example.tld`"
  type        = "string"
}

variable "nsxt_username" {
  description = "The NSX-T username, probably `admin`"
  type        = "string"
}

variable "nsxt_password" {
  description = "The NSX-T password"
  type        = "string"
}

variable "allow_unverified_ssl" {
  default     = false
  description = "Allow connection to NSX-T manager with self-signed certificates. Set to `true` for POC or development environments"
  type        = "string"
}

variable "environment_name" {
  description = "An identifier used to tag resources; examples: `dev`, `EMEA`, `prod`"
  type        = "string"
}

variable "east_west_transport_zone_name" {
  description = "The name of the Transport Zone that carries internal traffic between the NSX-T components. Also known as the `overlay` transport zone"
  type        = "string"
}

variable "external_ip_pool_cidr" {
  description = "The CIDR for the External IP Pool. Must be reachable from clients outside the foundation. Can be RFC1918 addresses (10.x, 172.16-31.x, 192.168.x), e.g. `10.195.74.0/24`"
  type        = "string"
}

variable "external_ip_pool_ranges" {
  description = "The IP Ranges for the External IP Pool. Each PAS Org will draw an IP address from this pool; make sure you have enough, e.g. `[\"10.195.74.128-10.195.74.250\"]`"
  type        = "list"
}

variable "external_ip_pool_gateway" {
  description = "The gateway for the External IP Pool, e.g. `10.195.74.1`"
  type        = "string"
}

variable "container_ip_block_name" {
  default     = "PAS-container-ip-block"
  description = "The name of the IP block from which subnets are allocated to each newly-created Org"
  type        = "string"
}

variable "container_ip_block_cidr" {
  default     = "10.12.0.0/14"
  description = "The CIDR of the container IP Block, e.g. `10.12.0.0/14`"
  type        = "string"
}

# }

# Logical Routers + Switches {
variable "nsxt_edge_cluster_name" {
  description = "The name of the deployed Edge Cluster, e.g. `edge-cluster-1`"
  type        = "string"
}

variable "nsxt_t0_router_name" {
  default     = "T0-Router"
  description = "The name of the T0 router"
  type        = "string"
}

variable "nat_gateway_ip" {
  description = "The IP Address of the SNAT rule for egress traffic from the Infra & Deployment subnets; should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.17`"
  type        = "string"
}

variable "om_ip" {
  description = "The public IP Address of the Operations Manager. The om's DNS (e.g. `om.system.tld`) should resolve to this IP, e.g. `10.195.74.16`"
  type        = "string"
}
# }

# Load Balancer {
variable "nsxt_lb_web_monitor_name" {
  default     = "pas-web-monitor"
  description = "The name of the Active Health Monitor (healthcheck) for Web (HTTP(S)) traffic"
  type        = "string"
}

variable "nsxt_lb_tcp_monitor_name" {
  default     = "pas-tcp-monitor"
  description = "The name of the Active Health Monitor (healthcheck) for TCP traffic"
  type        = "string"
}

variable "nsxt_lb_ssh_monitor_name" {
  default     = "pas-ssh-monitor"
  description = "The name of the Active Health Monitor (healthcheck) for SSH traffic"
  type        = "string"
}

variable "nsxt_lb_web_server_pool_name" {
  default     = "pas-web-pool"
  description = "The name of the Server Pool (collection of VMs which handle traffic) for Web (HTTP(S)) traffic"
  type        = "string"
}

variable "nsxt_lb_tcp_server_pool_name" {
  default     = "pas-tcp-pool"
  description = "The name of the Server Pool (collection of VMs which handle traffic) for TCP traffic"
  type        = "string"
}

variable "nsxt_lb_ssh_server_pool_name" {
  default     = "pas-ssh-pool"
  description = "The name of the Server Pool (collection of VMs which handle traffic) for SSH traffic"
  type        = "string"
}

variable "nsxt_lb_web_virtual_server_name" {
  default     = "pas-web-vs"
  description = "The name of the Virtual Server for Web (HTTP(S)) traffic"
  type        = "string"
}

variable "nsxt_lb_web_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for Web (HTTP(S)) traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.17`"
  type        = "string"
}

variable "nsxt_lb_web_virtual_server_ports" {
  default     = ["80", "443"]
  description = "The list of port(s) on which the Virtual Server listens for Web (HTTP(S)) traffic, e.g. `10.195.74.19`"
  type        = "list"
}

variable "nsxt_lb_tcp_virtual_server_name" {
  default     = "pas-tcp-vs"
  description = "The name of the Virtual Server for TCP traffic"
  type        = "string"
}

variable "nsxt_lb_tcp_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for TCP traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.19`"
  type        = "string"
}

variable "nsxt_lb_tcp_virtual_server_ports" {
  description = "The list of port(s) on which the Virtual Server listens for TCP traffic, e.g. `[\"8080\", \"52135\", \"34000-35000\"]`"
  type        = "list"
}

variable "nsxt_lb_ssh_virtual_server_name" {
  default     = "pas-ssh-vs"
  description = "The name of the Virtual Server for SSH traffic"
  type        = "string"
}

variable "nsxt_lb_ssh_virtual_server_ip_address" {
  description = "The ip address on which the Virtual Server listens for SSH traffic, should be in the same subnet as the external IP pool, but not in the range of available IP addresses, e.g. `10.195.74.18`"
  type        = "string"
}

variable "nsxt_lb_ssh_virtual_server_ports" {
  default     = ["2222"]
  description = "The list of port(s) on which the Virtual Server listens for SSH traffic"
  type        = "list"
}

variable "nsxt_lb_name" {
  default     = "pas-lb"
  description = "The name of the Load Balancer itself"
  type        = "string"
}

variable "nsxt_lb_size" {
  default     = "SMALL"
  description = "The size of the Load Balancer. Accepted values: SMALL, MEDIUM, or LARGE"
  type        = "string"
}
# }

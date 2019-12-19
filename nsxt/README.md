### Pre-requisites:
* NSX-T Manager deployed
* NSX-T Edge Cluster deployed
* An East-West Transport Zone created (e.g. `overlay-tz`)
* Tier-0 Router created and attached to North-South transport zone,
  most importantly, you should be able to ping the `external_ip_pool_gateway`
  from your workstation
* A DNS entry which resolves to your Operation Manager's IP address (e.g. `om.example.com` resolves to `10.195.74.16`)

### Quick Start

Download the NSX-T Terraform provider:
```
terraform init
```

Create and customize a file named `terraform.tfvars` using the following contents as a template:
```
nsxt_username = "admin"
nsxt_password = "a_secret_password"
nsxt_host = "nsxmgr.domain.tld"

env_name = "environment_name" # An identifier used to tag resources; examples: dev, EMEA, prod
east_west_transport_zone_name = "overlay-tz"

# Routers
nsxt_edge_cluster_name = "edge-cluster-1"
nat_gateway_ip = "10.195.74.251"
om_ip = "10.195.74.16"

# Each PAS Org will draw an IP address from this pool; make sure you have enough
# Your LB Virtual Servers, gateway, NAT gateway, OM should be in the CIDR but not in the available range
external_ip_pool_cidr    = "10.195.74.0/24"
external_ip_pool_ranges  = ["10.195.74.128-10.195.74.250"]
external_ip_pool_gateway = "10.195.74.1"

# LBs
nsxt_lb_web_virtual_server_ip_address = "10.195.74.17"
nsxt_lb_tcp_virtual_server_ip_address = "10.195.74.19"
nsxt_lb_ssh_virtual_server_ip_address = "10.195.74.18"

nsxt_lb_tcp_virtual_server_ports = ["8080", "52135", "34000-35000"]




# Optional Variables
# These variables have reasonable default values.
# if your foundation setup is tricky, you may need to set different values.
allow_unverified_ssl = true  # set to true if NSX manager's TLS cert is self-signed
nsxt_lb_web_virtual_server_ports = ["80", "443"]
nsxt_lb_ssh_virtual_server_ports = ["2222"]
```
Run terraform:
```bash
terraform plan
terraform apply
```


If you log in to your vCenter console, you should be able to find the opaque
networks `PAS-Infrastructure` and `PAS-Deployment` under the Navigator's "Networking" tab.

1. Follow [the pcf
   docs](https://docs.pivotal.io/pivotalcf/2-4/customizing/deploying-vm.html) to
   upload an opsman OVA. When it prompts you for a network, Select the opaque network
   `PAS-Infrastructure`.  When prompted for an
   IP address, use `192.168.1.10`.  When you reach the step to select "Power on after
   deployment," click yes and hit finish.

1. Follow along with the PCF documentation to [deploy a bosh
   director](https://docs.pivotal.io/pivotalcf/2-4/customizing/vsphere-config.html),
   but with the following changes:

  1. Under vCenter Config, enable `NSX networking → NSX-T Mode`, and supply your
     `nsxt_host`, `nsxt_username`, and `nsxt_password` from `terraform.tfvars`.

  1. When prompted to enter networks, use the values:

       |  | Infrastructure | Deployment |
       |---|---|---|
       | vSphere Network Name | `PAS-Infrastructure` | `PAS-Deployment` |
       | CIDR | `192.168.1.0/24` |  `192.168.2.0/24` |
       | Gateway |  `192.168.1.1` | `192.168.2.1` |
       | Reserved IP Ranges | `192.168.1.1-192.168.1.10` | `192.168.2.1` |

1. Follow along with the PCF documentation to [deploy
   PAS](https://docs.pivotal.io/pivotalcf/2-4/customizing/config-er-vmware.html),
   but also do the following:

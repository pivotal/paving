## Pre-requisites:

* NSX-T Manager deployed
* NSX-T Edge Cluster deployed
* An East-West Transport Zone created (e.g. `overlay-tz`)
* Tier-0 Router created and attached to North-South transport zone,
  most importantly, you should be able to ping the `external_ip_pool_gateway`
  from your workstation
* A DNS entry which resolves to your Operation Manager's IP address (e.g. `om.example.com` resolves to `10.195.74.16`)


## After paving the infrastructure 

If you log in to your vCenter console, you should be able to find the opaque
networks `PAS-Infrastructure` and `PAS-Deployment` under the Navigator's "Networking" tab.

1. Follow [the pcf docs](https://docs.pivotal.io/pivotalcf/2-4/customizing/deploying-vm.html) to
   upload an opsman OVA. When it prompts you for a network, Select the opaque network
   `PAS-Infrastructure`.  When prompted for an
   IP address, use `192.168.1.10`.  When you reach the step to select "Power on after
   deployment," click yes and hit finish.

1. Follow along with the PCF documentation to [deploy a bosh director](https://docs.pivotal.io/pivotalcf/2-4/customizing/vsphere-config.html),
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

1. Follow along with the PCF documentation to [deploy PAS](https://docs.pivotal.io/pivotalcf/2-4/customizing/config-er-vmware.html)

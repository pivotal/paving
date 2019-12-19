# Data {
data "nsxt_edge_cluster" "edge_cluster" {
  display_name var.nsxt_edge_cluster_name
}

data "nsxt_transport_zone" "east-west-overlay" {
  display_name = var.east_west_transport_zone_name
}
# }

# Tier-0 Routers {
data "nsxt_logical_tier0_router" "t0_router" {
  display_name = var.nsxt_t0_router_name
}

resource "nsxt_logical_router_link_port_on_tier0" "t0_to_t1_deployment" {
  display_name = "T0-to-T1-Deployment"

  description       = "Link Port on Logical Tier 0 Router for connecting to Tier 1 Deployment Router."
  logical_router_id = data.nsxt_logical_tier0_router.t0_router.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_router_link_port_on_tier0" "t0_to_t1_infrastructure" {
  display_name = "T0-to-T1-Infrastructure"

  description       = "Link Port on Logical Tier 0 Router for connecting to Tier 1 Infrastructure Router."
  logical_router_id = data.nsxt_logical_tier0_router.t0_router.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}
# }

# Tier-1 Router (Infrastructure) {
resource "nsxt_logical_tier1_router" "t1_infrastructure" {
  display_name = "T1-Router-PAS-Infrastructure"

  description     = "Infrastructure Tier 1 Router."

  enable_router_advertisement = true
  advertise_connected_routes  = true

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_router_link_port_on_tier1" "t1_infrastructure_to_t0" {
  display_name = "T1-Infrastructure-to-T0"

  description                   = "Link Port on Infrastructure Tier 1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = nsxt_logical_tier1_router.t1_infrastructure.id
  linked_logical_router_port_id = nsxt_logical_router_link_port_on_tier0.t0_to_t1_infrastructure.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_switch" "infrastructure_ls" {
  display_name = "PAS-Infrastructure"

  transport_zone_id = data.nsxt_transport_zone.east-west-overlay.id
  admin_state       = "UP"

  description      = "Logical Switch for the T1 Infrastructure Router."
  replication_mode = "MTEP"

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_port" "infrastructure_lp" {
  display_name = "PAS-Infrastructure-lp"

  admin_state       = "UP"
  description       = "Logical Port on the Logical Switch for the T1 Infrastructure Router."
  logical_switch_id = nsxt_logical_switch.infrastructure_ls.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_router_downlink_port" "infrastructure_dp" {
  display_name = "PAS-Infrastructure-dp"

  description                   = "Downlink port connecting PAS-Infrastructure router to its Logical Switch"
  logical_router_id             = nsxt_logical_tier1_router.t1_infrastructure.id
  linked_logical_switch_port_id = nsxt_logical_port.infrastructure_lp.id
  ip_address                    = "192.168.1.1/24"

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}
# }

# Tier-1 Router (Deployment) {
resource "nsxt_logical_tier1_router" "t1_deployment" {
  display_name = "T1-Router-PAS-Deployment"

  description     = "Deployment Tier 1 Router."
  failover_mode   = "NON_PREEMPTIVE"
  edge_cluster_id = data.nsxt_edge_cluster.edge_cluster.id

  enable_router_advertisement = true
  advertise_connected_routes  = true
  advertise_lb_vip_routes     = true

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_router_link_port_on_tier1" "t1_deployment_to_t0" {
  display_name = "T1-Deployment-to-T0"

  description                   = "Link Port on Deployment Tier 1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = nsxt_logical_tier1_router.t1_deployment.id
  linked_logical_router_port_id = nsxt_logical_router_link_port_on_tier0.t0_to_t1_deployment.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_switch" "deployment_ls" {
  display_name = "PAS-Deployment"

  transport_zone_id = data.nsxt_transport_zone.east-west-overlay.id
  admin_state       = "UP"

  description      = "Logical Switch for the T1 Deployment Router."
  replication_mode = "MTEP"

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_port" "deployment_lp" {
  display_name = "PAS-Deployment-lp"

  admin_state       = "UP"
  description       = "Logical Port on the Logical Switch for the T1 Deployment Router."
  logical_switch_id = nsxt_logical_switch.deployment_ls.id

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_logical_router_downlink_port" "deployment_dp" {
  display_name = "PAS-Deployment-dp"

  description                   = "Downlink port connecting PAS-Deployment router to its Logical Switch"
  logical_router_id             = nsxt_logical_tier1_router.t1_deployment.id
  linked_logical_switch_port_id = nsxt_logical_port.deployment_lp.id
  ip_address                    = "192.168.2.1/24"

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}
# }

# NAT Rules {
resource "nsxt_nat_rule" "snat_vm" {
  display_name = "snat-vm"
  action       = "SNAT"

  logical_router_id = data.nsxt_logical_tier0_router.t0_router.id
  description       = "SNAT Rule for all VMs in deployment with exception of sockets coming in through LBs"
  enabled           = true
  logging           = false
  nat_pass          = false

  match_source_network = "192.168.0.0/16"
  translated_network   = var.nat_gateway_ip

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_nat_rule" "snat_om" {
  display_name = "snat-om"
  action       = "SNAT"

  logical_router_id = data.nsxt_logical_tier0_router.t0_router.id
  description       = "SNAT Rule for Operations Manager"
  enabled           = true
  logging           = false
  nat_pass          = false

  match_source_network = "192.168.1.10"
  translated_network   = var.om_ip

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_nat_rule" "dnat_om" {
  display_name = "dnat-om"
  action       = "DNAT"

  logical_router_id = data.nsxt_logical_tier0_router.t0_router.id
  description       = "DNAT Rule for Operations Manager"
  enabled           = true
  logging           = false
  nat_pass          = false

  match_destination_network = var.om_ip
  translated_network        = "192.168.1.10"

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}
# }

# Extras {
resource "nsxt_ip_pool" "external_ip_pool" {
  description = "IP Pool that provides IPs for each of the NSX-T container networks."
  display_name = "external-ip-pool"

  subnet = {
    allocation_ranges = var.external_ip_pool_ranges
    cidr              = var.external_ip_pool_cidr
    gateway_ip        = var.external_ip_pool_gateway
  }

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_ip_block" "container_ip_block" {
  description  = "Subnets are allocated from this pool to each newly-created Org"
  display_name = var.container_ip_block_name
  cidr         = var.container_ip_block_cidr
}
# }

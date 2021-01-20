resource "nsxt_policy_tier1_gateway" "t1_infrastructure" {
  display_name = "${var.environment_name}-T1-Gateway-PAS-Infrastructure"
  description = "Infrastructure Tier 1 Gateway."
  tier0_path                = data.nsxt_policy_tier0_gateway.t0_gw.path
  failover_mode   = "PREEMPTIVE"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster.path
  route_advertisement_types = [
          "TIER1_IPSEC_LOCAL_ENDPOINT",
          "TIER1_LB_VIP", "TIER1_NAT",
          "TIER1_DNS_FORWARDER_IP",
          "TIER1_STATIC_ROUTES",
          "TIER1_LB_SNAT",
          "TIER1_CONNECTED"
        ]
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_segment" "infrastructure_sg" {
  display_name = "${var.environment_name}-PAS-Infrastructure"
  description      = "Segment for the Infrastructure."
  transport_zone_path = data.nsxt_policy_transport_zone.east-west-overlay.path
  connectivity_path   = nsxt_policy_tier1_gateway.t1_infrastructure.path

  subnet {
    cidr = "${var.subnet_prefix}.1.1/24"
  }
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_tier1_gateway" "t1_deployment" {
  display_name = "${var.environment_name}-T1-Gateway-PAS-Deployment"
  description     = "Deployment Tier 1 Gateway."
  tier0_path   = data.nsxt_policy_tier0_gateway.t0_gw.path
  failover_mode   = "NON_PREEMPTIVE"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edge_cluster.path
  route_advertisement_types = [
          "TIER1_IPSEC_LOCAL_ENDPOINT",
          "TIER1_LB_VIP", "TIER1_NAT",
          "TIER1_DNS_FORWARDER_IP",
          "TIER1_STATIC_ROUTES",
          "TIER1_LB_SNAT",
          "TIER1_CONNECTED"
        ]
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_segment" "deployment_sg" {
  display_name = "${var.environment_name}-PAS-Deployment"
  description      = "Segment for the Deployment."
  transport_zone_path = data.nsxt_policy_transport_zone.east-west-overlay.path
  connectivity_path   = nsxt_policy_tier1_gateway.t1_deployment.path
  subnet {
    cidr = "${var.subnet_prefix}.2.1/24"
  }
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_nat_rule" "snat_vm" {
  display_name = "${var.environment_name}-snat-vm"
  action       = "SNAT"

  gateway_path   = data.nsxt_policy_tier0_gateway.t0_gw.path
  description    = "SNAT Rule for all VMs in deployment with exception of sockets coming in through LBs"
  enabled        = true
  logging        = false
  firewall_match = "BYPASS"

  source_networks     = ["${var.subnet_prefix}.0.0/16"]
  translated_networks = [var.nat_gateway_ip]

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_nat_rule" "snat_om" {
  display_name = "${var.environment_name}-snat-om"
  action       = "SNAT"

  gateway_path   = data.nsxt_policy_tier0_gateway.t0_gw.path
  description    = "SNAT Rule for Operations Manager"
  enabled        = true
  logging        = false
  firewall_match = "BYPASS"

  source_networks     = ["${var.subnet_prefix}.1.10"]
  translated_networks = [var.ops_manager_public_ip]

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_nat_rule" "dnat_om" {
  display_name = "${var.environment_name}-dnat-om"
  action       = "DNAT"

  gateway_path   = data.nsxt_policy_tier0_gateway.t0_gw.path
  description    = "DNAT Rule for Operations Manager"
  enabled        = true
  logging        = false
  firewall_match = "BYPASS"

  destination_networks = [var.ops_manager_public_ip]
  translated_networks  = ["${var.subnet_prefix}.1.10"]

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_ip_pool" "external_ip_pool" {
  display_name = "pool1"
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_ip_pool_static_subnet" "subnet1" {
  description  = "IP Pool that provides IPs for each of the NSX-T container networks."
  display_name = "${var.environment_name}-external-ip-pool"
  pool_path    = nsxt_policy_ip_pool.external_ip_pool.path

  cidr       = var.external_ip_pool_cidr
  gateway = var.external_ip_pool_gateway

  allocation_range {
    start = var.external_ip_pool_ranges_start
    end   = var.external_ip_pool_ranges_end
  }

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_segment" "container_ip_block" {
  description  = "Subnets are allocated from this pool to each newly-created Org"
  display_name = "${var.environment_name}-pas-container-ip-block"
  transport_zone_path = data.nsxt_policy_transport_zone.east-west-overlay.path
  subnet {
    cidr       = "10.12.0.1/14"
  }
}

data "nsxt_policy_edge_cluster" "edge_cluster" {
  display_name = var.nsxt_edge_cluster_name
}

data "nsxt_policy_transport_zone" "east-west-overlay" {
  display_name = var.east_west_transport_zone_name
}

data "nsxt_policy_tier0_gateway" "t0_gw" {
  display_name = var.nsxt_t0_gateway_name
}
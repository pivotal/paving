data "nsxt_edge_cluster" "edge_cluster" {
  display_name = var.nsxt_edge_cluster_name
}

data "nsxt_transport_zone" "east-west-overlay" {
  display_name = var.east_west_transport_zone_name
}

data "nsxt_logical_tier0_router" "t0_router" {
  display_name = var.nsxt_t0_router_name
}
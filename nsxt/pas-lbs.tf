#resource "nsxt_policy_lb_monitor" "pas-web" {
#  description           = "The Active Health Monitor (healthcheck) for Web (HTTP(S)) traffic."
#  display_name          = "${var.environment_name}-pas-web-monitor"
#  type = "HTTP"
#  monitor_port          = 8080
#  request_method        = "GET"
#  request_url           = "/health"
#  request_version       = "HTTP_VERSION_1_1"
#  response_status_codes = [200]
#
#  tag {
#    scope = "terraform"
#    tag   = var.environment_name
#  }
#}
#
#resource "nsxt_policy_lb_monitor" "pas-tcp" {
#  description     = "The Active Health Monitor (healthcheck) for TCP traffic."
#  display_name    = "${var.environment_name}-pas-tcp-monitor"
#  type = "HTTP"
#  monitor_port    = 80
#  request_method  = "GET"
#  request_url     = "/health"
#  request_version = "HTTP_VERSION_1_1"
#
#  tag {
#    scope = "terraform"
#    tag   = var.environment_name
#  }
#  response_status_codes = [200]
#}
#
#resource "nsxt_lb_tcp_monitor" "pas-ssh" {
#  description  = "The Active Health Monitor (healthcheck) for SSH traffic."
#  display_name = "${var.environment_name}-pas-ssh-monitor"
#  monitor_port = 2222
#
#  tag {
#    scope = "terraform"
#    tag   = var.environment_name
#  }
#}

resource "nsxt_policy_lb_pool" "pas-web" {
  description              = "The Server Pool of Web (HTTP(S)) traffic handling VMs"
  display_name             = "${var.environment_name}-pas-web-pool"
  algorithm                = "ROUND_ROBIN"
  tcp_multiplexing_enabled = false
#  active_monitor_path        = nsxt_lb_http_monitor.pas-web.path
  snat {
    type = "AUTOMAP"
  }
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_lb_pool" "pas-tcp" {
  description              = "The Server Pool of TCP traffic handling VMs"
  display_name             = "${var.environment_name}-pas-tcp-pool"
  algorithm                = "ROUND_ROBIN"
  tcp_multiplexing_enabled = false
#  active_monitor_id        = nsxt_lb_http_monitor.pas-tcp.id
  snat {
    type = "DISABLED"
  }
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_lb_pool" "pas-ssh" {
  description              = "The Server Pool of SSH traffic handling VMs"
  display_name             = "${var.environment_name}-pas-ssh-pool"
  algorithm                = "ROUND_ROBIN"
  tcp_multiplexing_enabled = false
#  active_monitor_id        = nsxt_lb_tcp_monitor.pas-ssh.id
  snat {
    type = "DISABLED"
  }
  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

#resource "nsxt_lb_fast_tcp_application_profile" "pas_lb_tcp_application_profile" {
#  display_name  = "${var.environment_name}-pas-lb-tcp-application-profile"
#  close_timeout = "8"
#  idle_timeout  = "1800"
#
#  tag {
#    scope = "terraform"
#    tag   = var.environment_name
#  }
#}
#
#data "nsxt_policy_lb_app_profile" "pas_lb_tcp_application_profile" {
#  display_name  = "${var.environment_name}-pas-lb-tcp-application-profile"
#}

data "nsxt_policy_lb_app_profile" "pas_lb_tcp_application_profile" {
  display_name  = "default-tcp-lb-app-profile"
}

resource "nsxt_policy_lb_virtual_server" "lb_web_virtual_server" {
  description            = "The Virtual Server for Web (HTTP(S)) traffic"
  display_name           = "${var.environment_name}-pas-web-vs"
  application_profile_path = data.nsxt_policy_lb_app_profile.pas_lb_tcp_application_profile.path
  ip_address             = var.nsxt_lb_web_virtual_server_ip_address
  ports                  = ["80", "443"]
  pool_path                = nsxt_policy_lb_pool.pas-web.path
  service_path = nsxt_policy_lb_service.pas_lb.path

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_lb_virtual_server" "lb_tcp_virtual_server" {
  description            = "The Virtual Server for TCP traffic"
  display_name           = "${var.environment_name}-pas-tcp-vs"
  application_profile_path = data.nsxt_policy_lb_app_profile.pas_lb_tcp_application_profile.path
  ip_address             = var.nsxt_lb_tcp_virtual_server_ip_address
  ports                  = var.nsxt_lb_tcp_virtual_server_ports
  pool_path                = nsxt_policy_lb_pool.pas-tcp.path
  service_path = nsxt_policy_lb_service.pas_lb.path

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_lb_virtual_server" "lb_ssh_virtual_server" {
  description            = "The Virtual Server for SSH traffic"
  display_name           = "${var.environment_name}-pas-ssh-vs"
  application_profile_path = data.nsxt_policy_lb_app_profile.pas_lb_tcp_application_profile.path
  ip_address             = var.nsxt_lb_ssh_virtual_server_ip_address
  ports                  = ["2222"]
  pool_path                = nsxt_policy_lb_pool.pas-ssh.path
  service_path = nsxt_policy_lb_service.pas_lb.path

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

resource "nsxt_policy_lb_service" "pas_lb" {
  description  = "The Load Balancer for handling Web (HTTP(S)), TCP, and SSH traffic."
  display_name = "${var.environment_name}-pas-lb"
  enabled           = true
  connectivity_path = nsxt_policy_tier1_gateway.t1_deployment.path
  size              = "SMALL"
  depends_on = [
    nsxt_policy_segment.infrastructure_sg,
    nsxt_policy_segment.deployment_sg,
  ]

  tag {
    scope = "terraform"
    tag   = var.environment_name
  }
}

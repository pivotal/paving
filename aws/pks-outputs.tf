locals {
  stable_config_pks = {
    pks_master_iam_instance_profile_name = aws_iam_instance_profile.pks-master.name
    pks_worker_iam_instance_profile_name = aws_iam_instance_profile.pks-worker.name
    pks_api_dns = aws_route53_record.pks-api.name
    pks_subnet_ids = aws_subnet.pks-subnet[*].id
    pks_subnet_cidrs = aws_subnet.pks-subnet[*].cidr_block
    pks_subnet_gateways = [
    for i in range(length(var.availability_zones)) :
    cidrhost(aws_subnet.pks-subnet[i].cidr_block, 1)
    ]
    pks_subnet_reserved_ip_ranges = [
    for i in range(length(var.availability_zones)) :
    "${cidrhost(aws_subnet.pks-subnet[i].cidr_block, 1)}-${cidrhost(aws_subnet.pks-subnet[i].cidr_block, 9)}"
    ]
    pks_internal_security_group_id = aws_security_group.pks-internal-sg.id
    pks_internal_security_group_name = aws_security_group.pks-internal-sg.name
    pks_api_lb_security_group_id = aws_security_group.pks-api-lb.id
    pks_api_lb_security_group_name = aws_security_group.pks-api-lb.name
    pks_api_target_groups = [
      aws_lb_target_group.pks-api-9021.name,
      aws_lb_target_group.pks-api-8443.name]
  }
}

output "stable_config_pks" {
  value = jsonencode(local.stable_config_pks)
  sensitive = true
}

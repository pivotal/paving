locals {
  stable_config = {
    access_key         = var.access_key
    secret_key         = var.secret_key
    environment_name   = var.environment_name
    availability_zones = var.availability_zones
    region             = var.region

    bucket_pas_buildpacks = aws_s3_bucket.buildpacks-bucket.bucket
    bucket_pas_droplets   = aws_s3_bucket.droplets-bucket.bucket
    bucket_pas_packages   = aws_s3_bucket.packages-bucket.bucket
    bucket_pas_resources  = aws_s3_bucket.resources-bucket.bucket

    dns_wildcard_sys  = aws_route53_record.wildcard-sys.name
    dns_wildcard_apps = aws_route53_record.wildcard-apps.name
    dns_ssh           = aws_route53_record.ssh.name
    dns_tcp           = aws_route53_record.tcp.name
    dns_pks_api       = aws_route53_record.pks-api.name

    ops_manager_subnet_id                 = aws_subnet.public-subnet[0].id
    ops_manager_public_ip                 = aws_eip.ops-manager.public_ip
    ops_manager_dns                       = aws_route53_record.ops-manager.name
    ops_manager_iam_user_access_key       = aws_iam_access_key.ops-manager.id
    ops_manager_iam_user_secret_key       = aws_iam_access_key.ops-manager.secret
    ops_manager_iam_instance_profile_name = aws_iam_instance_profile.ops-manager.name
    ops_manager_key_pair_name             = aws_key_pair.ops-manager.key_name
    ops_manager_ssh_public_key            = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key           = tls_private_key.ops-manager.private_key_pem
    ops_manager_bucket                    = aws_s3_bucket.ops-manager-bucket.bucket
    ops_manager_security_group_id         = aws_security_group.ops-manager.id
    ops_manager_security_group_name       = aws_security_group.ops-manager.name

    security_group_platform_id       = aws_security_group.platform.id
    security_group_platform_name     = aws_security_group.platform.name
    security_group_nat_id            = aws_security_group.nat.id
    security_group_nat_name          = aws_security_group.nat.name
    security_group_ssh_lb_id         = aws_security_group.ssh-lb.id
    security_group_ssh_lb_name       = aws_security_group.ssh-lb.name
    security_group_tcp_lb_id         = aws_security_group.tcp-lb.id
    security_group_tcp_lb_name       = aws_security_group.tcp-lb.name
    security_group_web_lb_id         = aws_security_group.web-lb.id
    security_group_web_lb_name       = aws_security_group.web-lb.name
    security_group_mysql_id          = aws_security_group.mysql.id
    security_group_mysql_name        = aws_security_group.mysql.name
    security_group_pks_internal_id   = aws_security_group.pks-internal-sg.id
    security_group_pks_internal_name = aws_security_group.pks-internal-sg.name
    security_group_pks_api_lb_id     = aws_security_group.pks-api-lb.id
    security_group_pks_api_lb_name   = aws_security_group.pks-api-lb.name

    subnet_public_ids       = aws_subnet.public-subnet[*].id
    subnet_public_cidrs     = aws_subnet.public-subnet[*].cidr_block
    subnet_management_ids   = aws_subnet.management-subnet[*].id
    subnet_management_cidrs = aws_subnet.management-subnet[*].cidr_block
    subnet_pas_ids          = aws_subnet.pas-subnet[*].id
    subnet_pas_cidrs        = aws_subnet.pas-subnet[*].cidr_block
    subnet_services_ids     = aws_subnet.services-subnet[*].id
    subnet_services_cidrs   = aws_subnet.services-subnet[*].cidr_block
    subnet_pks_ids          = aws_subnet.pks-subnet[*].id
    subnet_pks_cidrs        = aws_subnet.pks-subnet[*].cidr_block

    target_groups_web     = [aws_lb_target_group.web-80.name, aws_lb_target_group.web-443.name]
    target_groups_tcp     = aws_lb_target_group.tcp[*].name
    target_groups_ssh     = aws_lb_target_group.ssh.name
    target_groups_pks_api = [aws_lb_target_group.pks-api-9021.name, aws_lb_target_group.pks-api-8443.name]

    vpc_id = aws_vpc.vpc.id
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}

locals {
  stable_config = {
    region = var.region

    vpc_subnet_id = aws_vpc.vpc.id

    ops_manager_security_group            = aws_security_group.ops-manager.id
    ops_manager_public_ip                 = aws_eip.ops-manager.public_ip
    ops_manager_dns                       = aws_route53_record.ops-manager.name
    ops_manager_iam_user_access_key       = aws_iam_access_key.ops-manager.id
    ops_manager_iam_user_secret_key       = aws_iam_access_key.ops-manager.secret
    ops_manager_iam_instance_profile_name = aws_iam_instance_profile.ops-manager.name
    ops_manager_key_pair_name             = aws_key_pair.ops-manager.key_name
    ops_manager_ssh_public_key            = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key           = tls_private_key.ops-manager.private_key_pem
    ops_manager_bucket                    = aws_s3_bucket.ops-manager-bucket.bucket

    wildcard_sys_dns  = aws_route53_record.wildcard-sys.name
    wildcard_apps_dns = aws_route53_record.wildcard-apps.name
    ssh_dns           = aws_route53_record.ssh.name
    tcp_dns           = aws_route53_record.tcp.name
    pks_api_dns       = aws_route53_record.pks-api.name

    platform_security_group     = aws_security_group.platform.id
    nat_security_group          = aws_security_group.nat.id
    ssh_lb_security_group       = aws_security_group.ssh-lb.id
    tcp_lb_security_group       = aws_security_group.tcp-lb.id
    web_lb_security_group       = aws_security_group.web-lb.id
    mysql_security_group        = aws_security_group.mysql.id
    pks_internal_security_group = aws_security_group.pks-internal.id
    pks_api_lb_security_group   = aws_security_group.pks-api-lb.id

    pas_buildpacks_bucket = aws_s3_bucket.buildpacks-bucket.bucket
    pas_droplets_bucket   = aws_s3_bucket.droplets-bucket.bucket
    pas_packages_bucket   = aws_s3_bucket.packages-bucket.bucket
    pas_resources_bucket  = aws_s3_bucket.resources-bucket.bucket

    web_target_groups     = [aws_lb_target_group.web-80.name, aws_lb_target_group.web-443.name]
    tcp_target_groups     = aws_lb_target_group.tcp[*].name
    ssh_target_groups     = aws_lb_target_group.ssh.name
    pks_api_target_groups = [aws_lb_target_group.pks-api-9021.name, aws_lb_target_group.pks-api-8443.name]

    public_subnet_ids       = aws_subnet.public-subnet[*].id
    public_subnet_cidrs     = aws_subnet.public-subnet[*].cidr_block
    management_subnet_ids   = aws_subnet.management-subnet[*].id
    management_subnet_cidrs = aws_subnet.management-subnet[*].cidr_block
    pas_subnet_ids          = aws_subnet.pas-subnet[*].id
    pas_subnet_cidrs        = aws_subnet.pas-subnet[*].cidr_block
    services_subnet_ids     = aws_subnet.services-subnet[*].id
    services_subnet_cidrs   = aws_subnet.services-subnet[*].cidr_block
    pks_subnet_ids          = aws_subnet.pks-subnet[*].id
    pks_subnet_cidrs        = aws_subnet.pks-subnet[*].cidr_block
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}

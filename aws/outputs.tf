locals {
  stable_config = {
    region = var.region

    vpc_subnet_id = aws_vpc.vpc.id

    ops_manager_security_group      = aws_security_group.ops-manager.id
    ops_manager_public_ip           = aws_eip.ops-manager.public_ip
    ops_manager_dns                 = aws_route53_record.ops-manager.name
    ops_manager_iam_user_access_key = aws_iam_access_key.ops-manager.id
    ops_manager_iam_user_secret_key = aws_iam_access_key.ops-manager.secret
    ops_manager_key_pair_name       = aws_key_pair.ops-manager.key_name
    ops_manager_bucket              = aws_s3_bucket.ops-manager-bucket.bucket

    wildcard_sys_dns  = aws_route53_record.wildcard-sys.name
    wildcard_apps_dns = aws_route53_record.wildcard-apps.name
    ssh_dns           = aws_route53_record.ssh.name
    tcp_dns           = aws_route53_record.tcp.name
    pks_api_dns       = aws_route53_record.pks-api.name

    pas_buildpacks_bucket = aws_s3_bucket.buildpacks-bucket.bucket
    pas_droplets_bucket   = aws_s3_bucket.droplets-bucket.bucket
    pas_packages_bucket   = aws_s3_bucket.packages-bucket.bucket
    pas_resources_bucket  = aws_s3_bucket.resources-bucket.bucket

    web_target_groups     = [aws_lb_target_group.web-80.name, aws_lb_target_group.web-443.name]
    tcp_target_groups     = aws_lb_target_group.tcp[*].name
    ssh_target_groups     = aws_lb_target_group.ssh.name
    pks_api_target_groups = [aws_lb_target_group.pks-api-9021.name, aws_lb_target_group.pks-api-8443.name]
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}

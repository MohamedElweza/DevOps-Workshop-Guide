output "sqs_url" { value = aws_sqs_queue.app_queue.id }

output "rds_endpoint" { value = aws_db_instance.rds_instance.address }

output "memcached_endpoint" { value = aws_elasticache_cluster.memcached.cache_nodes[0].address }

output "elb_dns_name" { value = aws_lb.web_elb.dns_name }

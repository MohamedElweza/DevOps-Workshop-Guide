
resource "aws_elasticache_cluster" "memcached" {
  cluster_id      = "memcached-cluster"
  engine         = "memcached"
  node_type      = "cache.t3.micro"
  parameter_group_name = "default.memcached1.6"
  num_cache_nodes     = 1
  port                = 11211
  subnet_group_name   = aws_elasticache_subnet_group.memcached_subnet_group.name
}

resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name       = "memcached-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id]
}

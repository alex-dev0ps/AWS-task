########### Aurora MySQL ################
resource "aws_rds_cluster" "dbc" {
  cluster_identifier      = "aurora-cluster"
  availability_zones      = [data.aws_availability_zones.av-azs.names[0], data.aws_availability_zones.av-azs.names[1], data.aws_availability_zones.av-azs.names[2]]
  engine                  = "aurora-mysql"
  database_name           = "wordpressaurora"
  master_username         = "alex"
#   master_password         = "alex1234"
  backup_retention_period = 5
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.dbsg.id]
  depends_on              = [aws_db_subnet_group.db_subg]
  db_subnet_group_name    = aws_db_subnet_group.db_subg.name
  manage_master_user_password = true
}

resource "aws_db_subnet_group" "db_subg" {
  name       = "db_subg"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id, aws_subnet.private-3.id]
}

resource "aws_rds_cluster_instance" "test1" {
  cluster_identifier   = aws_rds_cluster.dbc.id
  identifier           = "test1"
  instance_class       = "db.t3.large"
  engine               = aws_rds_cluster.dbc.engine
  db_subnet_group_name = aws_db_subnet_group.db_subg.name
  tags = {
    name = "clust_instance_1"
  }
}

resource "aws_rds_cluster_instance" "test2" {
  cluster_identifier   = aws_rds_cluster.dbc.id
  identifier           = "test2"
  instance_class       = "db.t3.large"
  engine               = aws_rds_cluster.dbc.engine
  db_subnet_group_name = aws_db_subnet_group.db_subg.name
  tags = {
    name = "clust_instance_2"
  }
}

resource "aws_rds_cluster_instance" "test3" {
  cluster_identifier   = aws_rds_cluster.dbc.id
  identifier           = "test3"
  instance_class       = "db.t3.large"
  engine               = aws_rds_cluster.dbc.engine
  db_subnet_group_name = aws_db_subnet_group.db_subg.name
  tags = {
    name = "clust_instance_3"
  }
}

resource "aws_rds_cluster_instance" "test4" {
  cluster_identifier   = aws_rds_cluster.dbc.id
  identifier           = "test4"
  instance_class       = "db.t3.large"
  engine               = aws_rds_cluster.dbc.engine
  db_subnet_group_name = aws_db_subnet_group.db_subg.name
  tags = {
    name = "clust_instance_4"
  }
}

resource "aws_rds_cluster_endpoint" "reader1" {
  cluster_identifier          = aws_rds_cluster.dbc.id
  cluster_endpoint_identifier = "reader1"
  custom_endpoint_type        = "READER"

  static_members = [aws_rds_cluster_instance.test1.id]
}

resource "aws_rds_cluster_endpoint" "reader2" {
  cluster_identifier          = aws_rds_cluster.dbc.id
  cluster_endpoint_identifier = "reader2"
  custom_endpoint_type        = "READER"

  static_members = [aws_rds_cluster_instance.test2.id]
}

resource "aws_rds_cluster_endpoint" "reader3" {
  cluster_identifier          = aws_rds_cluster.dbc.id
  cluster_endpoint_identifier = "reader3"
  custom_endpoint_type        = "READER"

  static_members = [aws_rds_cluster_instance.test3.id]
}

resource "aws_rds_cluster_endpoint" "any" {
  cluster_identifier          = aws_rds_cluster.dbc.id
  cluster_endpoint_identifier = "any"
  custom_endpoint_type        = "ANY"

  static_members = [aws_rds_cluster_instance.test4.id]
}

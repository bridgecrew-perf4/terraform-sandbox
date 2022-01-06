# resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
#     cluster_identifier = aws_rds_cluster.system_aurora_cluster.id
#     identifier                = "aurora"
#     count         = 1
#     engine                    = aws_rds_cluster.system_aurora_cluster.engine
#     engine_version            = aws_rds_cluster.system_aurora_cluster.engine_version
#     instance_class            = "db.t3.small"
#     publicly_accessible       = false
#     availability_zone         = "ap-northeast-1a"
#     db_parameter_group_name      = "default.aurora5.6"
# }

# resource "aws_rds_cluster" "system_aurora_cluster" {
#     cluster_identifier = "aurora-cluster"
#     engine = "aurora"
#     engine_version            = "5.6.mysql_aurora.1.22.2"
#     database_name  = "test"
#     master_username = "root"
#     master_password = "dummy1234%"
#     port                      = 3306
#     availability_zones = ["ap-northeast-1a"]
#     vpc_security_group_ids    = [aws_security_group.aurora_sg.id]
#     db_subnet_group_name      = "db-subnet"
#     db_cluster_parameter_group_name      = "default.aurora5.6"
#     backup_retention_period   = 1
#     preferred_backup_window = "17:22-17:52"
#     preferred_maintenance_window = "tue:19:59-tue:20:29"

#     tags={
#         Name = "aurora-cluster"
#    }
# }
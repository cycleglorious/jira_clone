# resource "aws_security_group" "jira-clone-app" {
#   name        = "jira-clone-app-sg"
#   description = "Jira clone app security group"

#   vpc_id = aws_vpc.jira-clone.id

#   tags = {
#     Name = "jira-clone-app-sg"
#     app  = local.tags.app
#   }
# }

# resource "aws_security_group_rule" "jira-clone-ssh-ingress" {
#   security_group_id = aws_security_group.jira-clone-app.id
#   description       = "Allow SSH"
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "jira-clone-app-ingress" {
#   security_group_id = aws_security_group.jira-clone-app.id
#   description       = "Allow HTTP"
#   type              = "ingress"
#   from_port         = 3000
#   to_port           = 3000
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group" "jira-clone-db" {
#   name        = "jira-clone-db-sg"
#   description = "Jira clone db security group"

#   vpc_id = aws_vpc.jira-clone.id

#   tags = {
#     Name = "jira-clone-db-sg"
#     app  = local.tags.app
#   }
# }

# resource "aws_security_group_rule" "jira-clone-db-ingress" {
#   security_group_id = aws_security_group.jira-clone-db.id
#   description       = "Allow DB"
#   type              = "ingress"
#   from_port         = 5432
#   to_port           = 5432
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"] # TODO: change to CIDR of private subnet
# }

module "jira_clone_app_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${local.app_name}-app-sg"
  description = "Jira clone app security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "Allow HTTP to port 3000"
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Name = "${local.app_name}-app-sg"
    app  = local.tags.app
  }
}
module "jira_clone_db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name                = "${local.app_name}-db-sg"
  description         = "Jira clone db security group"
  vpc_id              = module.vpc.vpc_id
  
  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_with_cidr_blocks = [
    {
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"
      description = "Allow Postgres"
    }
  ]

  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

  tags = {
    Name = "${local.app_name}-db-sg"
    app  = local.tags.app
  }
}

resource "aws_security_group" "jira-clone-app" {
  name        = "jira-clone-app-sg"
  description = "Jira clone app security group"

  vpc_id = aws_vpc.jira-clone.id

  tags = {
    Name = "jira-clone-app-sg"
    app  = local.tags.app
  }
}

resource "aws_security_group_rule" "jira-clone-ssh-ingress" {
  security_group_id = aws_security_group.jira-clone-app.id
  description       = "Allow SSH"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jira-clone-app-ingress" {
  security_group_id = aws_security_group.jira-clone-app.id
  description       = "Allow HTTP"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "jira-clone-db" {
  name        = "jira-clone-db-sg"
  description = "Jira clone db security group"

  vpc_id = aws_vpc.jira-clone.id

  tags = {
    Name = "jira-clone-db-sg"
    app  = local.tags.app
  }
}

resource "aws_security_group_rule" "jira-clone-db-ingress" {
  security_group_id = aws_security_group.jira-clone-db.id
  description       = "Allow DB"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # TODO: change to CIDR of private subnet
}

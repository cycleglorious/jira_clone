resource "aws_vpc" "jira-clone" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "jira-clone-vpc"
    app  = local.tags.app
  }
}

# Subnets
resource "aws_subnet" "jira-clone-public" {
  count                   = length(var.cidr_public_subnets)
  vpc_id                  = aws_vpc.jira-clone.id
  cidr_block              = element(var.cidr_public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  depends_on              = [aws_vpc.jira-clone]
  map_public_ip_on_launch = true

  tags = {
    Name                                   = "jira-clone-public-subnet-${count.index + 1}"
    app                                    = local.tags.app
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/jira-clone-eks" = "owned"
  }
}

resource "aws_subnet" "jira-clone-private" {
  count             = length(var.cidr_private_subnets)
  vpc_id            = aws_vpc.jira-clone.id
  cidr_block        = element(var.cidr_private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  depends_on        = [aws_vpc.jira-clone]

  tags = {
    Name                                   = "jira-clone-private-subnet-${count.index + 1}"
    app                                    = local.tags.app
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/jira-clone-eks" = "owned"
  }
}

# Internet gateway
resource "aws_internet_gateway" "jira-clone" {
  vpc_id     = aws_vpc.jira-clone.id
  depends_on = [aws_vpc.jira-clone]

  tags = {
    Name                                   = "jira-clone-igw"
    app                                    = local.tags.app
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/jira-clone-eks" = "owned"
  }
}

resource "aws_eip" "jira-clone" {
  tags = {
    Name = "jira-clone-eip"
    app  = local.tags.app

  }
}

resource "aws_nat_gateway" "jira-clone" {
  depends_on    = [aws_eip.jira-clone]
  subnet_id     = aws_subnet.jira-clone-public[0].id
  allocation_id = aws_eip.jira-clone.id

  tags = {
    Name = "jira-clone-nat"
    app  = local.tags.app

  }
}

# Route tables
resource "aws_route_table" "jira-clone-public" {
  vpc_id = aws_vpc.jira-clone.id

  tags = {
    Name = "jira-clone-public-rt"
    app  = local.tags.app
  }
}

resource "aws_route" "jira-clone-public-igw" {
  route_table_id         = aws_route_table.jira-clone-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jira-clone.id
}

resource "aws_route_table_association" "jira-clone-public-subnet" {
  count          = length(aws_subnet.jira-clone-public)
  route_table_id = aws_route_table.jira-clone-public.id
  subnet_id      = element(aws_subnet.jira-clone-public.*.id, count.index)
}

resource "aws_route_table" "jira-clone-private" {
  vpc_id = aws_vpc.jira-clone.id

  tags = {
    Name = "jira-clone-private-rt"
    app  = local.tags.app

  }
}

resource "aws_route" "jira-clone-private-nat" {
  route_table_id         = aws_route_table.jira-clone-private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.jira-clone.id
}

resource "aws_route_table_association" "jira-clone-private-subnet" {
  count          = length(aws_subnet.jira-clone-private)
  route_table_id = aws_route_table.jira-clone-private.id
  subnet_id      = element(aws_subnet.jira-clone-private.*.id, count.index)
}

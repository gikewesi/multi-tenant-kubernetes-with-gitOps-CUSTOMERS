resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

# Associate public subnets
resource "aws_route_table_association" "public_assoc" {
  for_each = toset(values(var.public_subnet_ids))
  subnet_id      = each.key
  route_table_id = aws_route_table.public.id
}

# Private Route Tables
resource "aws_route_table" "private" {
  for_each = var.private_subnet_ids
  vpc_id   = var.vpc_id
  tags = {
    Name = "${var.name}-private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat" {
  for_each               = var.private_subnet_ids
  route_table_id          = aws_route_table.private[each.key].id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = var.nat_gateway_ids[each.key]
}

# Associate private subnets
resource "aws_route_table_association" "private_assoc" {
  for_each       = var.private_subnet_ids
  subnet_id      = each.key
  route_table_id = aws_route_table.private[each.key].id
}

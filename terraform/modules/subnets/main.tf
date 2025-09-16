resource "aws_subnet" "public" {
  count                   = length(var.public_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "${var.name}-private-${count.index+1}"
  }
}

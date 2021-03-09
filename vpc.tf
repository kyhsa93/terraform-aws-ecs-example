resource "aws_default_vpc" "default-vpc" {}

resource "aws_default_subnet" "ap-northeast-2a" {
  availability_zone = "ap-northeast-2a"
}

resource "aws_default_subnet" "ap-northeast-2b" {
  availability_zone = "ap-northeast-2b"
}

resource "aws_default_subnet" "ap-northeast-2c" {
  availability_zone = "ap-northeast-2c"
}

resource "aws_default_subnet" "ap-northeast-2d" {
  availability_zone = "ap-northeast-2d"
}

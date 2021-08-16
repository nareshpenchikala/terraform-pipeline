provider "aws" {
    region = "ap-south-1"
    access_key = var.access
    secret_key = var.secret
}


resource "aws_vpc" "terraform-vpc" {
    cidr_block = "10.158.16.0/24"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags= {
        Name = "terraform"
    }
}

resource "aws_subnet" "sub-1" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    cidr_block ="10.158.16.0/26"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1b"
    tags= {
       Name = "public"
    }
}

resource "aws_subnet" "sub-2" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    cidr_block ="10.158.16.64/26"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags= {
       Name = "public"
    }
}

resource "aws_subnet" "sub-3" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    cidr_block ="10.158.16.128/26"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1b"
    tags= {
       Name = "public"
    }
}


resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    tags= {
       Name = "internet-gateway"
    }
}

resource "aws_route_table" "rt1" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    tags ={
       Name = "Default"
    }
}

resource "aws_route_table" "rt2" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    tags ={
       Name = "Default"
    }
}

resource "aws_route_table" "rt3" {
    vpc_id = "${aws_vpc.terraform-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    tags ={
       Name = "Default"
    }
}


resource "aws_route_table_association" "association-subnet-1" {
     subnet_id = "${aws_subnet.sub-1.id}"
     route_table_id = "${aws_route_table.rt1.id}"
}

resource "aws_route_table_association" "association-subnet-2" {
     subnet_id = "${aws_subnet.sub-2.id}"
     route_table_id = "${aws_route_table.rt2.id}"
}

resource "aws_route_table_association" "association-subnet-3" {
     subnet_id = "${aws_subnet.sub-3.id}"
     route_table_id = "${aws_route_table.rt3.id}"
}

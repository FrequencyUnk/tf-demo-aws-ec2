output "public_dns" {
  value = "${aws_instance.app_server.public_dns}"
}

output "ubuntu_iteration" {
  value = data.hcp_packer_iteration.ubuntu
}

output "ubuntu_us_east_2" {
  value = data.hcp_packer_image.ubuntu_us_east_2
}

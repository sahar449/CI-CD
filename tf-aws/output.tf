output "eip_jenkins" {
  value = aws_eip.eip_jenkins.public_ip
}

output "eip_ansible_master" {
  value = aws_eip.eip_ansible.public_ip
}

output "ansible_node1" {
  value = aws_eip.ansible_node1.public_ip
}

output "docker" {
  value = aws_eip.docker.public_ip
}

output "nexus" {
  value = aws_eip.nexus.public_ip
}
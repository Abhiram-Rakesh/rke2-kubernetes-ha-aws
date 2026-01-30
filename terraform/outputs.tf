
output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "control_plane_ips" {
  value = aws_instance.control_plane[*].private_ip
}

output "worker_ips" {
  value = aws_instance.worker[*].private_ip
}

output "ssh_key_path" {
  value = local_file.private_key.filename
}

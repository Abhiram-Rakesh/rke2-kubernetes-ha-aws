resource "local_file" "inventory" {
  filename = "${path.module}/../inventory/inventory.json"

  content = jsonencode({
    nginx_lb = {
      public_ip  = aws_instance.nginx.public_ip
      private_ip = aws_instance.nginx.private_ip
    }
    control_plane = aws_instance.control_plane[*].private_ip
    workers       = aws_instance.worker[*].private_ip
    ssh_key       = abspath(local_file.private_key.filename)
    rke2_version  = var.rke2_version
  })
}

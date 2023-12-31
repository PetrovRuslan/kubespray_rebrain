output "master_ip_addresses" {
  value = {
    for key, instance in exoscale_compute_instance.master :
    instance.name => {
      "private_ip" = contains(keys(data.exoscale_compute_instance.master_nodes), key) ? data.exoscale_compute_instance.master_nodes[key].private_network_ip_addresses[0] : ""
      "public_ip"  = exoscale_compute_instance.master[key].ip_address
    }
  }
}

output "worker_ip_addresses" {
  value = {
    for key, instance in exoscale_compute_instance.worker :
    instance.name => {
      "private_ip" = contains(keys(data.exoscale_compute_instance.worker_nodes), key) ? data.exoscale_compute_instance.worker_nodes[key].private_network_ip_addresses[0] : ""
      "public_ip"  = exoscale_compute_instance.worker[key].ip_address
    }
  }
}

output "cluster_private_network_cidr" {
  value = var.private_network_cidr
}

output "ingress_controller_lb_ip_address" {
  value = exoscale_elastic_ip.ingress_controller_lb.ip_address
}

output "control_plane_lb_ip_address" {
  value = exoscale_elastic_ip.control_plane_lb.ip_address
}

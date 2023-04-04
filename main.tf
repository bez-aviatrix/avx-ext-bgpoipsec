terraform {
  required_providers {
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "3.0.0"
    }
  }
}

provider "aviatrix" {
    skip_version_validation = true
}

data "aviatrix_transit_gateway" "tx" {
  gw_name = var.gw_name
}

resource "aviatrix_transit_external_device_conn" "ext" {
    vpc_id = data.aviatrix_transit_gateway.tx.vpc_id
    connection_name = "remote-site"
    gw_name = data.aviatrix_transit_gateway.tx.gw_name
    remote_gateway_ip = var.pri_remote_gw_ip
    connection_type = "bgp"
    bgp_local_as_num = data.aviatrix_transit_gateway.tx.local_as_number
    bgp_remote_as_num = var.remote_asn
    ha_enabled = true
    backup_bgp_remote_as_num = var.remote_asn
    backup_remote_gateway_ip = var.bkp_remote_gw_ip
    enable_ikev2 = true
    custom_algorithms = true
    phase_1_authentication = "SHA-512"
    phase_2_authentication = "NO-AUTH"
    phase_1_dh_groups = "14"
    phase_2_dh_groups = "14"
    phase_1_encryption = "AES-256-GCM-128"
    phase_2_encryption = "AES-256-GCM-128"
    local_tunnel_cidr = "169.254.12.1/30,169.254.12.5/30"
    remote_tunnel_cidr = "169.254.12.2/30,169.254.12.6/30"
    backup_local_tunnel_cidr = "169.254.22.1/30,169.254.22.5/30"
    backup_remote_tunnel_cidr = "169.254.22.2/30,169.254.22.6/30"
}
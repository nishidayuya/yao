module Yao::Resources
  class Port < Base

    include NetworkAssociationable
    include TenantAssociationable

    friendly_attributes :name, :mac_address, :status, :allowed_address_pairs,
                        :device_owner, :fixed_ips, :security_groups, :device_id,
                        :admin_state_up
    map_attribute_to_attribute "binding:host_id" => :host_id

    # @return [String]
    def primary_ip
      fixed_ips.first["ip_address"]
    end

    # @return [Yao::Resources::Subnet]
    def primary_subnet
      @subnet ||= Yao::Subnet.find fixed_ips.first["subnet_id"]
    end

    self.service        = "network"
    self.resource_name  = "port"
    self.resources_name = "ports"
  end
end

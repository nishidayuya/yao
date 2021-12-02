module Yao::Resources
  class Router < Base
    include TenantAssociationable

    friendly_attributes :name, :description, :admin_state_up, :status, :external_gateway_info,
                        :network_id, :enable_snat, :external_fixed_ips, :routes, :destination, :nexthop, :distributed,
                        :ha, :availability_zone_hints, :availability_zones

    self.service        = 'network'
    self.resource_name  = 'router'
    self.resources_name = 'routers'

    # @return [Array<Yao::Resources::Port>]
    def interfaces
      Yao::Port.list(device_id: id)
    end

    class << self
      # @param id [String]
      # @param param [Hash]
      # @return [Hash]
      def add_interface(id, param)
        PUT(['routers', id, 'add_router_interface.json'].join('/'), param.to_json)
      end

      # @param id [String]
      # @param param [Hash]
      # @return [Hash]
      def remove_interface(id, param)
        PUT(['routers', id, 'remove_router_interface.json'].join('/'), param.to_json)
      end

      # @param name [String]
      # @return [Array<Yao::Resources::Router>]
      def get_by_name(name)
        self.list(name: name)
      end
      alias find_by_name get_by_name
    end
  end
end

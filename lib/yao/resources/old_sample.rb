module Yao::Resources
  class OldSample < Base
    include TenantAssociationable

    friendly_attributes :counter_name, :counter_type, :counter_unit, :counter_volume,
                        :message_id, :resource_id, :timestamp, :resource_metadata, :user_id,
                        :source

    # @return [Date]
    def recorded_at
      Time.parse(self["recorded_at"] || self["timestamp"])
    end
    alias timestamp recorded_at

    # @return [String]
    def id
      message_id
    end

    # @return [Yao::Resources::Resource]
    def resource
      @resource ||= Yao::Resource.get(resource_id)
    end

    # @return [Yao::Resources::User]
    def user
      @user ||= Yao::User.get(user_id)
    end

    self.service        = "metering"
    self.api_version    = "v2"

    # get /v2/meters/{id} returns samples!
    def self.list(meter_name, query={})
      cache_key = [meter_name, *query].join
      cache[cache_key] = GET("#{self.api_version}/meters/#{meter_name}", query).body unless cache[cache_key]
      cache[cache_key].map{|d| new(d) }
    end

    def self.cache
      @@_cache ||= {}
    end

    # TODO: implement `def self.create'
  end
end

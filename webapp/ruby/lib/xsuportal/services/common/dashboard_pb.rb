# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/common/dashboard.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("xsuportal/services/common/dashboard.proto", :syntax => :proto3) do
    add_message "xsuportal.proto.common.DashboardRequest" do
    end
    add_message "xsuportal.proto.common.DashboardResponse" do
    end
  end
end

module Xsuportal
  module Proto
    module Common
      DashboardRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.common.DashboardRequest").msgclass
      DashboardResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.common.DashboardResponse").msgclass
    end
  end
end

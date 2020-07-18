# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/bench/receiving.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("xsuportal/services/bench/receiving.proto", :syntax => :proto3) do
    add_message "xsuportal.proto.services.bench.ReceiveBenchmarkJobRequest" do
      optional :instance_name, :string, 1
      optional :team_id, :int64, 2
    end
    add_message "xsuportal.proto.services.bench.ReceiveBenchmarkJobResponse" do
      optional :job_id, :int64, 1
      optional :handle, :string, 2
      optional :target_ipv4_address, :string, 3
      optional :description_human, :string, 4
    end
  end
end

module Xsuportal
  module Proto
    module Services
      module Bench
        ReceiveBenchmarkJobRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.bench.ReceiveBenchmarkJobRequest").msgclass
        ReceiveBenchmarkJobResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.bench.ReceiveBenchmarkJobResponse").msgclass
      end
    end
  end
end

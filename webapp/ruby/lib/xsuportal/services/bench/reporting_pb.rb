# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/bench/reporting.proto

require 'google/protobuf'

require 'xsuportal/resources/benchmark_result_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("xsuportal/services/bench/reporting.proto", :syntax => :proto3) do
    add_message "xsuportal.proto.services.bench.ReportBenchmarkResultRequest" do
      optional :job_id, :int64, 1
      optional :handle, :string, 2
      optional :result, :message, 3, "xsuportal.proto.resources.BenchmarkResult"
    end
    add_message "xsuportal.proto.services.bench.ReportBenchmarkResultResponse" do
    end
  end
end

module Xsuportal
  module Proto
    module Services
      module Bench
        ReportBenchmarkResultRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.bench.ReportBenchmarkResultRequest").msgclass
        ReportBenchmarkResultResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.bench.ReportBenchmarkResultResponse").msgclass
      end
    end
  end
end

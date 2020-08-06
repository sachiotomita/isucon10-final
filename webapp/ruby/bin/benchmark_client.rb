#!/usr/bin/env ruby

$: << File.expand_path('../lib', __dir__)
require 'socket'
require 'griffin'
require 'xsuportal/services/bench/receiving_pb'
require 'xsuportal/services/bench/reporting_pb'
require 'xsuportal/services/bench/receiving_services_pb'
require 'xsuportal/services/bench/reporting_services_pb'

HOST = ENV.fetch('GRPC_HOST', 'localhost')
PORT = ENV.fetch('GRPC_PORT', 50051)

class ServiceClientBase
  def socket
    @socket ||= TCPSocket.new(HOST, PORT)
  end

  def close
    @socket.close if @socket
  end
end

class ReportServiceClient < ServiceClientBase
  def stub
    @stub ||= Xsuportal::Proto::Services::Bench::BenchmarkReport::Stub.new(socket)
  end

  def report_benchmark_result
    @call = stub.report_benchmark_result({})
  end

  def call
    @call
  end

  def make_request(opts)
    Xsuportal::Proto::Services::Bench::ReportBenchmarkResultRequest.new(opts)
  end
end

class QueueServiceClient < ServiceClientBase
  def stub
    @stub ||= Xsuportal::Proto::Services::Bench::BenchmarkQueue::Stub.new(socket)
  end

  def receive_benchmark_job(request_opts)
    request = make_request(request_opts)
    stub.receive_benchmark_job(request)
  end

  def make_request(opts)
    Xsuportal::Proto::Services::Bench::ReceiveBenchmarkJobRequest.new(opts)
  end
end

class BenchmarkClient
  SLEEP_INTERVAL = 1

  def initialize
  end

  def start
    loop do
      response = queue_service_client.receive_benchmark_job({})
      if response.job_handle
        puts "Received job: #{response.job_handle}"
        do_benchmark(response.job_handle)
      else
        sleep SLEEP_INTERVAL
      end
    end
  end

  def do_benchmark(job_handle)
    call = report_service_client.report_benchmark_result
    puts "Executing benchmark..."
    request = report_service_client.make_request({
      job_id: job_handle.job_id,
      result: {
        finished: false
      },
    })
    call.send_msg(request)

    sleep 1

    request = report_service_client.make_request({
      job_id: job_handle.job_id,
      result: {
        finished: true,
        passed: true,
        score: 1000,
        score_breakdown: {
          base: 1200,
          deduction: 200,
        },
        reason: 'REASON',
        stdout: 'succeeded',
        stderr: 'no error',
      },
    })
    puts "Finished benchmark! result=#{request}"
    call.send_msg(request)
  end

  def queue_service_client
    @queue_service_client ||= QueueServiceClient.new
  end

  def report_service_client
    @report_service_client ||= ReportServiceClient.new
  end
end

client = BenchmarkClient.new
client.start
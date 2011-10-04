#encoding: utf-8

require 'bundler/setup'
require 'mongo_stats'
require 'json'
require 'time'


class ServerAction < Cramp::Action
  on_start :memory_usage
  periodic_timer :memory_usage, :every => 10

  def respond_with
    [200,{'Content-Type' => 'application/json'}]
  end

  def memory_usage
    server_stats = MONGOSTATS_CONNECTION.server_stats
    render ({:type => "mongodb server memory",
            :time => Time.now.iso8601 ,
            :data => {:memory_usage => server_stats.mem,
                      :host => "localhost" }}).to_json
  end

end



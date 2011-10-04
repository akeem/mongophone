#encoding:  utf-8

require 'bundler/setup'
require 'mongo_stats'
require 'json'
require 'time'

class MongoAction < Cramp::Action
  on_start :fetch_db_stats
  periodic_timer :fetch_db_stats, :every => 10

  def respond_with
    [200,{'Content-Type' => 'application/json'}]
  end

  def fetch_db_stats
    database_name = params[:name]
    database_stats = MONGOSTATS_CONNECTION.db_stats(database_name)
    render ({:type => "mongo db collection count",
            :time => Time.now.iso8601 ,
            :data => {:collectionSize => database_stats.collections,
                      :database_name => database_name,
                      :host => "localhost" }}).to_json
  end

end

require 'bundler/setup'
require 'active_record'

env = ENV['DB'] || ENV['RACK_ENV'] || ENV['MERB_ENV'] || ENV['RAILS_ENV'] || 'development'

# activerecord
database_file = File.expand_path "#{File.dirname __FILE__}/config/database.yml"
database_config = YAML.load( File.read database_file )[ env ]
ActiveRecord::Base.establish_connection(database_config)

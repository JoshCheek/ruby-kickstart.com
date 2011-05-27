require 'bundler/setup'
require 'active_record'

env = ENV['DB'] || ENV['RACK_ENV'] || ENV['MERB_ENV'] || ENV['RAILS_ENV'] || 'development'

# activerecord
case env
when 'production', :production
  database_file = "/data/rubykickstartcom/shared/config/database.yml"
when 'development', :development, 'test', :test
  database_file = File.expand_path "#{File.dirname __FILE__}/db/database.yml"
end
database_config = YAML.load( File.read database_file )[ env ]
ActiveRecord::Base.establish_connection(database_config)

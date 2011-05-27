require 'bundler/setup'
require 'active_record'

# activerecord
case ENV['RACK_ENV']
when 'production', :production
  database_file = "/data/rubykickstartcom/shared/config/database.yml"
when 'development', :development, 'test', :test
  database_file = File.expand_path "#{File.dirname __FILE__}/db/database.yml"
end
database_config = YAML.load( File.read database_file )[ ENV['RACK_ENV'] ]
ActiveRecord::Base.establish_connection(database_config)

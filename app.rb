# NEED TO ADD SQLITE3 TO GEMFILE BEFORE COMMITTING
# BUT I LOST INTERNET CONNECTION AND CAN'T LOOK UP GEM NAME

require 'yaml'
require 'bundler/setup'
require 'sinatra'
require 'active_record'

# activerecord
case settings.environment  
when 'production', :production
  database_file = "/data/rubykickstartcom/shared/config/database.yml"
when 'development', :development
  database_file = File.dirname(__FILE__) + "/db/database.yml"
end
database_config = YAML.load( File.read database_file )[ settings.environment.to_s ]
ActiveRecord::Base.establish_connection(database_config)



get '/' do
  haml :home
end

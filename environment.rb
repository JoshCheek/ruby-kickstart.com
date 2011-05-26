require 'bundler/setup'
require 'yaml'
require 'sinatra'
require 'active_record'

$root = File.expand_path(File.dirname __FILE__)
$: << $root

# activerecord
case settings.environment  
when 'production', :production
  database_file = "/data/rubykickstartcom/shared/config/database.yml"
when 'development', :development, 'test', :test
  database_file = File.dirname(__FILE__) + "/db/database.yml"
end
database_config = YAML.load( File.read database_file )[ settings.environment.to_s ]
ActiveRecord::Base.establish_connection(database_config)

# load models
models_pattern = "#{File.dirname __FILE__}/app/models/*"
Dir[models_pattern].each do |model|
  next unless model[/\.rb$/]
  require model.sub(/^\.rb$/,'')
end

# set views
set :views, File.dirname(__FILE__) + '/app/views'

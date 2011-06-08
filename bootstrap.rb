require 'bundler/setup'
require 'yaml'
require 'sinatra'
require 'active_record'
require "active_record/acts/list.rb"
require 'omniauth'

$root = File.expand_path(File.dirname __FILE__)
$: << $root

require 'bootstrap_database'
ActiveRecord::Base.send :include, ActiveRecord::Acts::List # It's stupid that I have to do this, maybe I'll override its behaviour

# load models
models_pattern = "#{File.dirname __FILE__}/app/models/*"
Dir[models_pattern].each do |model|
  next unless model[/\.rb$/]
  require model.sub(/^\.rb$/,'')
end


set :views, File.dirname(__FILE__) + '/app/views'
enable :sessions

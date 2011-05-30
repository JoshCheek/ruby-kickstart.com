require 'bundler/setup'
require 'yaml'
require 'sinatra'
require 'active_record'

$root = File.expand_path(File.dirname __FILE__)
$: << $root

require 'bootstrap_database'

# load acts_as_list
require "active_record/acts/list.rb"
ActiveRecord::Base.send :include, ActiveRecord::Acts::List


# load models
models_pattern = "#{File.dirname __FILE__}/app/models/*"
Dir[models_pattern].each do |model|
  next unless model[/\.rb$/]
  require model.sub(/^\.rb$/,'')
end

# set views
set :views, File.dirname(__FILE__) + '/app/views'

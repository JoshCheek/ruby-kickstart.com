require 'bundler/setup'
require 'yaml'
require 'coderay'
require 'kramdown'
require 'sinatra'
require 'active_record'
require 'erb'



module Kramdown
  module Options
    @options[:coderay_line_numbers]  = Definition.new :coderay_line_numbers , Symbol , nil , "" # nil means no line numbers
  end
end

Tilt.prefer(Tilt::KramdownTemplate)

$root = File.expand_path(File.dirname __FILE__)
$: << $root

require 'bootstrap_database'
require 'acts_as_list'

# load models
models_pattern = "#{File.dirname __FILE__}/app/models/*"
Dir[models_pattern].each do |model|
  next unless model[/\.rb$/]
  require model.sub(/^\.rb$/,'')
end


set :views, File.dirname(__FILE__) + '/app/views'

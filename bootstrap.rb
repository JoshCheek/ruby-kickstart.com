require 'bundler/bouncer'
require 'yaml'
require 'coderay'
require 'kramdown'
require 'sinatra'
require 'active_record'
require "active_record/acts/list.rb"
require 'omniauth'
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
ActiveRecord::Base.send :include, ActiveRecord::Acts::List # It's stupid that I have to do this, maybe I'll override its behaviour

# load models
models_pattern = "#{File.dirname __FILE__}/app/models/*"
Dir[models_pattern].each do |model|
  next unless model[/\.rb$/]
  require model.sub(/^\.rb$/,'')
end


set :views, File.dirname(__FILE__) + '/app/views'

configure :development, :test do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
end

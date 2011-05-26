# set proper env
ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'test'

# load the application code
require File.expand_path("#{File.dirname __FILE__}/../environment")

# since we're doing this in memory, have to explicitly run migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{$root}/db/migrations", nil)

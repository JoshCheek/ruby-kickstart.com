# ==========  Helpers  ==========

task :bootstrap do
  require './bootstrap'
end

task :dangerous! do
  if %w(DB RACK_ENV MERB_ENV RAILS_ENV).any? { |key| ENV[key] == 'production' }
    $stderr.puts "\e[31mTHIS SHOULDN'T BE RUN IN PRODUCTION MODE\e[0m"
    exit 1
  end
end



# ==========  Miscellaneous  ==========

desc 'compare app to specs'
task :spec do
  sh  'bin/rspec '              +
      '--color '                +
      '--format=documentation ' +
      'spec/**_spec.rb'
end

desc 'run the features'
task :cuke do
  sh 'bin/cucumber features'
end

desc 'run the server on port 9394'
task :server do
  sh "bin/shotgun config.ru -p #{ENV['port']||9394}"
end

desc 'open console into app'
task :console do
  sh 'bin/pry -r ./bootstrap'
end

desc 'run in production environment'
task :ep do
  ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'production'  
end

desc 'run in development environment'
task :ed do
  ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'development'
end

desc 'run in test environment'
task :et do
  ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'test'
end



# ==========  Database  ==========
require 'tasks/standalone_migrations'

database_file = ENV['RACK_ENV'] == 'production' ? 
                  "/data/rubykickstartcom/shared/config/database.yml" : 
                  "#{File.dirname __FILE__}/config/database.yml"

MigratorTasks.new do |t|
  t.migrations  =  "db/migrations"
  t.config      =  database_file
  t.verbose     =  true
end

namespace :db do
  desc 'wipe the db out -- DANGEROUS!'
  task :reset => [ :dangerous!, 'db:drop', 'db:migrate' ]
  
  desc 'populate the quizzes into the db'
  task :populate => :bootstrap
end

Dir.glob('db/quizzes/*.rake') { |file| import file }

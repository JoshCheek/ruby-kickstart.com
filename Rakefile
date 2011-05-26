require 'bundler/setup'


# ==========  Miscellaneous  ==========

desc 'compare app to specs'
task :spec do
  sh  'rspec '                  +
      '--color '                +
      '--format=documentation ' +
      'spec/**_spec.rb'
end

desc 'run the server on port 9394'
task :server do
  sh 'shotgun config.ru -p 9394'
end

desc 'ssh into deploy environment'
task :ssh do
  sh 'ssh deploy@ec2-184-73-246-218.compute-1.amazonaws.com'
end

desc 'open console into app'
task :console do
  sh 'pry -r ./environment'
end

task :load_env do
  require './environment'
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
                  "#{File.dirname __FILE__}/db/database.yml"

MigratorTasks.new do |t|
  t.migrations  =  "db/migrations"
  t.config      =  database_file
  t.verbose     =  true
end

namespace :db do
  task :populate => :load_env do
    Quiz.add 1, 'Chapter 1 Quiz' do
      problem 'What is a set of instructions called?', :match => /method/i
      problem 'What is 10 / 4', :match => /\b2\b|\btwo\b/i
      problem 'What does the dollar sign mean in cases like "$ ruby -v"', :solution => 3, :options => [
        "It means you get paid if the code works.",
        "It means you should be careful when using this code.",
        "It means you should enter this in your text editor.",
        "It means you should enter this at the command line",
      ]
    end
  end
end
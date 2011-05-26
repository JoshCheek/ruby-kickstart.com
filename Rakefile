require 'bundler/setup'


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
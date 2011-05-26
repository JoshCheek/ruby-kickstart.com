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

MigratorTasks.new do |t|
  t.sub_namespace  =  "quizzes"
  t.migrations     =  "db/quiz-migrations"
  t.config         =  database_file
  t.verbose        =  true
end



# ==========  Miscellaneous  ==========

task :spec do
  sh  'rspec '                  +
      '--color '                +
      '--format=documentation ' +
      'spec/**_spec.rb'
end

task :server do
  sh 'shotgun config.ru -p 9394'
end

task :ssh do
  sh 'ssh deploy@ec2-184-73-246-218.compute-1.amazonaws.com'
end

task :console do
  sh 'pry -r ./environment'
end
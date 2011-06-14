begin
  raise unless defined? Bundler
rescue
  if 'no' != ENV['USE_BUNDLER']
    $stderr.puts "Looks like you're running this without having Bundler loaded."
    $stderr.puts "Try again with `bundle exec rake ...`"
    $stderr.puts "or check out https://github.com/mpapis/rubygems-bundler"
    exit 1
  end
  $stderr.puts  "\e[33mYou aren't using Bundler, but it looks intentional, " \
                "so not not going to kill the app.\e[0m"
end

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


# ==========  Environment Vars & Maintenance Mode  ==========
task :env => 'env:list' # because namespaces don't have defaults
namespace :env do
  
  def heroku(args)
    raise "need to invoke with USE_BUNDLER=no" unless 'no' == ENV['USE_BUNDLER']
    sh "heroku #{args}"
  end
  
  desc "Lists current ENV vars on Heroku"
  task :list do
    heroku 'config'
  end
  
  desc 'Add ENV var to Heroku'
  task :add do
    key = ENV['key']
    value = ENV['value']
    raise "expected key=name_of_env_var" unless key
    raise "expected val=value_of_env_var" unless value
    heroku "config:add #{key.inspect}=#{value.inspect}"
  end
  
  desc 'Remove ENV var from Heroku'
  task :remove do
    key = ENV['key']
    raise "expected key=name_of_env_var" unless key
    heroku "config:remove #{key.inspect}"
  end
  
  namespace :maint do
    desc 'Put app into maintenance mode'  
    task :on do
      ENV['key'] = 'DOING_MAINTENANCE'
      ENV['value'] = 'true'
      Rake::Task['env:add'].invoke
    end
    
    desc 'Take app out of maintenance mode'
    task :off do
      ENV['key'] = 'DOING_MAINTENANCE'
      Rake::Task['env:remove'].invoke
    end
  end
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
  
  desc "Populate the quizzes into the db."
  task :populate => :bootstrap
end

Dir.glob('db/quizzes/*.rake') { |file| import file }

namespace :db do
  desc 'migrate the database'
  task :migrate do
  end
end

task :spec do
  system  'rspec '                  +
          '--color '                +
          '--format=documentation ' +
          'spec/**_spec.rb'
end

task :server do
  system 'shotgun config.ru -p 9394'
end

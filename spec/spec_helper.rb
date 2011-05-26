# set proper env
ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'test'

# load the application code
require File.expand_path("#{File.dirname __FILE__}/../bootstrap")

# since we're doing this in memory, have to explicitly run migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{$root}/db/migrations", nil)


def clean_db
  [Quiz, QuizProblem, QuizOption, QuizRegex, QuizMatchAnswerProblem, QuizMultipleChoiceProblem].each(&:delete_all)
end

def block_based_reinit
  clean_db
  Quiz.add 5, 'Example Problem' do
    add_problem :multiple_choice do
      set_question  'can you see this?'
      add_option    'yes' , :solution => true
      add_option    'no'
    end
    add_problem :match_answer do
      set_question  "what is an object?"
      should_match  /data/i
      should_match  /methods/i
    end
  end
end

def hash_based_reinit
  clean_db
  Quiz.add 5, 'Example Problem' do
    problem 'can you see this?', :options => ['yes', 'no'], :solution => 0
    problem 'what is an object?', :match => [/data/i, /methods/i]
  end
end


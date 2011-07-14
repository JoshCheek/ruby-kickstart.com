# set proper env
ENV['DB'] = ENV["RACK_ENV"] = ENV['MERB_ENV'] = ENV['RAILS_ENV'] = 'test'

# load the db
require File.expand_path("#{File.dirname __FILE__}/../bootstrap_database")

# migrate the db -- since we're doing this in memory, have to explicitly run migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate(
  File.expand_path("#{File.dirname __FILE__}/../db/migrations"), nil
)

# load the rest of the environment
require File.expand_path("#{File.dirname __FILE__}/../bootstrap")



def clean_db
  [Quiz, QuizProblem, QuizRegex, QuizMatchAnswerProblem, QuizMultipleChoiceProblem, QuizTaken, QuizPredicateProblem].each(&:delete_all)
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
    add_problem :predicate do
      set_question "do vegetarians rock?"
      expect true
    end
    add_problem :many_to_many do
      set_question "Many to many question."
      subproblem "a", "x"
      subproblem "b", "y"
      subproblem "c", "x"
      presentation_order %w(i x j y k)
    end
  end
end

def hash_based_reinit
  clean_db
  Quiz.add 5, 'Example Problem' do
    problem 'can you see this?', :options => ['yes', 'no'], :solution => 0
    problem 'what is an object?', :match => [/data/i, /methods/i]
    problem 'do vegetarians rock?', :predicate => true
    problem "Many to many question.", :mappings => { 'a' => 'x', 'b' => 'y' , 'c' => 'x' }, :presentation_order => %w(i x j y k)
  end
end


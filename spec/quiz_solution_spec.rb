require 'spec_helper'

describe QuizSolution do
  
  before :each do
    clean_db
    @quiz = Quiz.add 5, 'Example Problem' do
      problem 'can you see this?', :options => ['yes', 'no'], :solution => 0
      problem 'what is an object?', :match => [/data/i, /methods/i]
      problem 'Hamburger is good.', :predicate => false
      problem "Match em up" , :mappings => { '1 + 1' => '2', '2 + 2' => '3' }, :presentation_order => %w(1 2 3 4 5)
    end
    
    define_singleton_method :valid_solutions do
      { @quiz.quiz_problems[0].id => 0,
        @quiz.quiz_problems[1].id => "data and methods",
        @quiz.quiz_problems[2].id => false,
        @quiz.quiz_problems[3].id => { '1 + 1' => '2', '2 + 2' => '3' },
      }
    end
    
    @quiz_taken = QuizTaken.new :quiz => @quiz
    @quiz_taken.apply_solutions valid_solutions
  end
  
  subject do
    @quiz_taken.quiz_solutions.first
  end
  
  it { should be_instance_of QuizSolution }
  its(:quiz)          { should == @quiz }
  its(:quiz_taken)    { should == @quiz_taken }
  its(:quiz_problem)  { should == @quiz.quiz_problems.first }
  
end
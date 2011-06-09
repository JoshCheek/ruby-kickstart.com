require 'spec_helper'

describe QuizTaken do
  
  before :each do
    clean_db
    
    @quiz = Quiz.add 5, 'Example Problem' do
      problem 'can you see this?', :options => ['yes', 'no'], :solution => 0
      problem 'what is an object?', :match => [/data/i, /methods/i]
    end
        
    define_singleton_method :valid_solutions do
      {@quiz.quiz_problems[0].id => 0 , @quiz.quiz_problems[1].id => "data and methods"}
    end
    
    define_singleton_method :invalid_keys do
      {@quiz.quiz_problems[0].id => 0 , @quiz.quiz_problems[1].id.next => "data and methods"}
    end

    define_singleton_method :invalid_values do
      {@quiz.quiz_problems[0].id => 'this should be an index' , @quiz.quiz_problems[1].id.next => "data and methods"}
    end
    
    @user = User.create :provider => 'provider',
                        :uid      => 'uid',
                        :name     => 'Josh Cheek'
  end

  subject do
    QuizTaken.new :user => @user, :quiz => @quiz
  end

  its(:quiz) { should == @quiz }
  its(:user) { should == @user }
  
  context 'should not be valid without' do
    specify 'user' do
      subject.user = nil
      should_not be_valid
    end
    specify 'quiz' do
      subject.quiz = nil
      should_not be_valid
    end
  end
  
  specify "its quiz problems should be the same as its quiz's" do
    subject.quiz_problems.should == subject.quiz.quiz_problems
  end
  
  it 'should have a solution for every problem' do
    should have(2).quiz_problems
    should have(2).quiz_solutions
  end
  
  describe '.quiz_solutions' do
    it 'should be unsaved before .apply_solutions' do
      subject.quiz_solutions.should be_all &:new_record?
    end
  end
  
  describe '.each_solution' do
    it 'should yield its solutions in order' do
      subject.quiz_solutions.map(&:quiz_problem).should == subject.quiz_problems
    end
  end
  
  describe '#each_problem_with_solution_and_index' do
    it 'should yield its problems in order' do
      problems = Array.new
      subject.each_problem_with_solution_and_index { |problem,_,__| problems << problem }
      problems.should == subject.quiz_problems.map(&:problemable)
    end
    it 'should yield its solutions in order' do
      solutions = Array.new
      subject.each_problem_with_solution_and_index { |_,solution,__| solutions << solution }
      solutions.should == subject.quiz_solutions.map(&:solutionable)
    end
    it 'should yield indexes incrementing from 1' do
      indexes = Array.new
      subject.each_problem_with_solution_and_index { |_,__,index| indexes << index }
      indexes.should == [1, 2]
    end
  end
  
  describe '.apply_solutions' do
    it 'should enable saving' do
      should_not be_valid 
      should be_new_record
      subject.apply_solutions valid_solutions
      should be_valid
      subject.save.should be
      should_not be_new_record
    end
    it 'should save when its keys match its quiz problems' do
      subject.apply_solutions valid_solutions
      should_not be_new_record
    end
    it 'should not save when its keys do not match its quiz problems' do
      subject.apply_solutions invalid_keys
      should be_new_record
    end
    it 'should not save when its its values do not match its quiz problems' do
      subject.apply_solutions invalid_values
      should be_new_record
    end
    it 'should not care whether its keys are integers or strings' do
      valid_with_string_keys = {}
      valid_solutions.each { |key, value| valid_with_string_keys[key.to_s] = value }
      subject.apply_solutions valid_with_string_keys
      should_not be_new_record
    end
    it 'should have saved solutions after a successful application' do
      subject.apply_solutions valid_solutions
      subject.quiz_solutions.should_not be_all &:new_record?
    end
  end
        
end
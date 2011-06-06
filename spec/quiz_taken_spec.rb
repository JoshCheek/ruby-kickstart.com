require 'spec_helper'

describe QuizTaken do
  
  before :each do
    clean_db
    @quiz = Quiz.add 5, 'Example Problem' do
      problem 'can you see this?', :options => ['yes', 'no'], :solution => 0
      problem 'what is an object?', :match => [/data/i, /methods/i]
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
  
  describe '.apply_solutions' do
    it 'should enable saving' do
      should_not be_valid
      should be_new_record
      subject.apply_solutions 1 => 0, 2 => 'data and methods'
      should be_valid
      subject.save.should be
      should_not be_new_record
    end
    it 'should save when its keys match its quiz problems' do
      pending
      subject.apply_solutions 1 => 0, 2 => 'data and methods'
      should_not be_new_record
    end
    it 'should not save when its keys do not match its quiz problems'    
    it 'should not save when its its values do not match its quiz problems'
    it 'should not care whether its keys are integers or strings'
    it 'should have saved solutions after a successful application'
  end
        
end
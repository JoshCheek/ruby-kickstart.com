require 'spec_helper'

describe QuizProblem do
  
  before :each do
    @quiz = hash_based_reinit
    @problem1 = QuizProblem.first
    @problem2 = QuizProblem.last
    QuizProblem.count.should == 2
  end
  
  describe '#position' do
    
    it "should be added in consecutive positive integers" do
      @problem1.position.should == 1
      @problem2.position.should == 2
    end
    
    describe 'Quiz#each_problem' do
      it 'should display in the given order' do
        problems = Array.new
        @quiz.each_problem_with_index { |problem, index| problems << problem << index }
        problems.should == [@problem1.problemable, 1, @problem2.problemable, 2]
      end
      
      specify 'when order is changed, it should display in the new order' do
        @problem1.update_attributes :position => 3
        problems = Array.new
        @quiz.each_problem_with_index { |problem, index| problems << problem << index }
        problems.should == [@problem2.problemable, 2, @problem1.problemable, 3]
      end
    end
    
  end
end
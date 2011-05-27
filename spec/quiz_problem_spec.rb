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
        @quiz.each_problem { |problem| problems << problem }
        problems.should == [@problem1.problemable, @problem2.problemable]
      end
      
      specify 'when order is changed, it should display in the new order' do
        ActiveRecord::Base.transaction do
          @problem1.update_attributes :position => 2
          @problem2.update_attributes :position => 1
        end
        problems = Array.new
        @quiz.each_problem { |problem| problems << problem }
        problems.should == [@problem2.problemable, @problem1.problemable]
      end
    end
    
  end
end
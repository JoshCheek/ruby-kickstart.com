require 'spec_helper'

describe QuizProblem do
    
  describe '#position' do
    before :each do
      @quiz = hash_based_reinit
      @problem1 = QuizProblem.first
      @problem2 = QuizProblem.last
      QuizProblem.count.should == 2
    end
    
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
    
    context 'when having several problems' do
      specify '#position should be incrementing' do
        quiz = Quiz.add 100, 'Example Problem' do
          problem 'one'   , :options => %w(yes no), :solution => 0
          problem 'two'   , :match   => [/a/i, /b/i]
          problem 'three' , :options => %w(abc), :solution => 0
          problem 'four'  , :match   => /c/i
        end
        indexes = []
        quiz.each_problem_with_index do |problem, index| 
          indexes << index
        end
        indexes.should == [1, 2, 3, 4]
      end
    end
    
  end
end
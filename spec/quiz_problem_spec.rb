require 'spec_helper'

describe QuizProblem do
  
  before :each do
    @quiz = hash_based_reinit
  end
  
  describe '#position' do
    
    it "shouldn't be able to duplicate for a given quiz" do
      qp = QuizProblem.new :quiz => @quiz, :problemable => QuizRegex.create, :position => 1
      qp.save.should_not be
    end
    
    it "should be added in consecutive positive integers"
    
    describe 'Quiz#each_problem' do
      it 'should display in the given order'
      specify 'when order is changed, it should display in the new order'
    end
    
  end
end
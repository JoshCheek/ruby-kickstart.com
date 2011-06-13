require 'spec_helper'

describe Quiz do
  specs = lambda do |syntax_context, reinit_function|
    context syntax_context do
      
      before(:all) { reinit_function.call }
    
      describe '.add' do
        after(:all) { reinit_function.call }
        it 'should not need a block' do
          lambda { Quiz.add 1 , 'Another Example' }.should_not raise_error
        end
        it 'should return an instance of quiz' do
          Quiz.add(2,'example again').should be_instance_of Quiz
        end
      end
    
      context 'one quiz' do
        subject { Quiz.find_by_number 5 }
        its(:name) { should == 'Example Problem' }
        its(:inspect) { should == "<Quiz:Example Problem>" }
        it { should == Quiz.find_by_number(5) }
        it { should have(4).problems }
        it 'should yield all problems to each_problem' do
          problems = Array.new
          subject.each_problem { |problem| problems << problem }
          problems.should == subject.problems
        end
        it 'should yield all problems and their positions to each_problem_with_index' do
          problems = Array.new
          subject.each_problem_with_index { |problem, index| problems << problem << index }
          problems.should == subject.problems.zip((1..subject.problems.size).to_a).flatten
        end
      end
      
      describe '#each_id_problem_and_index' do
        subject { Quiz.find_by_number 5 }
        it 'should yield the ids of its problems' do
          ids = Array.new
          subject.each_id_problem_and_index { |id,_,__| ids << id }
          subject.quiz_problems.map(&:id).should == ids
        end
        it 'should yield all problems' do
          problems = Array.new
          subject.each_id_problem_and_index { |_,problem,__| problems << problem }
          problems.should == subject.problems
        end
        it 'should yield increasing indexes beginning at 1' do
          indexes = Array.new
          subject.each_id_problem_and_index { |_,__,index| indexes << index }
          indexes.should == (1..subject.problems.size).to_a
        end
      end
    
      describe 'multiple choice problem' do
        subject { Quiz.find_by_number(5).problems.first }
        it { should be_instance_of QuizMultipleChoiceProblem }
        its(:question) { should == 'can you see this?' }
        its(:options) { should == %w(yes no) }
      end
    
      describe 'match answer problem' do
        subject { Quiz.find_by_number(5).problems[1] }
        it { should be_instance_of QuizMatchAnswerProblem }
        its(:question) { should == 'what is an object?' }
        specify '#each_regex should yield both regexes' do
          regexes = Array.new
          subject.each_regex { |regex| regexes << regex }
          regexes.should == [/data/i,/methods/i]
        end
      end
      
      describe 'predicate problem' do
        subject { Quiz.find_by_number(5).problems[2] }
        it { should be_instance_of QuizPredicateProblem }
        its(:question) { should == 'do vegetarians rock?' }
        its(:predicate) { should == true }
      end
      
      describe 'many_to_many problem' do
        subject { Quiz.find_by_number(5).problems[3] }
        it { should be_instance_of QuizManyToManyProblem }
        its(:question)  { should == "Many to many question." }
        its(:question_set) { should == %w[a b c] }
        its(:solution_set) { should == %w[i x j y k] }
      end
    
      context 'when adding another quiz for the same number' do
        subject { Quiz.add 5 , 'duplicate quiz number' }
        specify { Quiz.count.should == 1 }
        it { should be_new_record }
      end
      
    end
  end
  
  specs.call 'with block based syntax', method(:block_based_reinit)
  specs.call 'with hash based syntax', method(:hash_based_reinit)
  
  context 'with one hash based problem matching to one regex' do
    describe 'its problem' do
      specify '#each_regex should yield one regex' do
        quiz = Quiz.add 1, 'Example Problem' do
          problem 'What is 10 / 4', :match => /\b2\b|\btwo\b/i
        end
        regexes = Array.new
        quiz.problems.first.each_regex { |regex| regexes << regex }
        regexes.should == [/\b2\b|\btwo\b/i]
      end    
    end
  end
  
end



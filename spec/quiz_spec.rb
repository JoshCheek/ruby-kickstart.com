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
        it { should have(2).problems }
        it 'should yield both problems to each_problem' do
          problems = Array.new
          subject.each_problem { |problem| problems << problem }
          problems.should == subject.problems
        end
      end
    
      describe 'multiple choice problem' do
        subject { Quiz.find_by_number(5).problems.first }
        it { should be_instance_of QuizMultipleChoiceProblem }
        its(:question) { should == 'can you see this?' }
        its(:options) { should == %w(yes no) }
        describe '#each_option' do
          it 'should yield both options' do
            options = Array.new
            subject.each_option { |_,option| options << option }
            options.should == subject.options
          end
          it 'should yield increasing numbers beginning at 1' do
            numbers = Array.new
            subject.each_option { |number,_| numbers << number }
            numbers.should == [1,2]
          end
          specify 'its solution should be the one specified' do
            subject.solution.body.should == 'yes'
          end
        end
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



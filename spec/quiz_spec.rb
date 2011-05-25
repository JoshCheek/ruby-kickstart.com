require 'spec_helper'
require 'app/models/quiz'

describe Quiz do

  before do
    Quiz.new 5, 'Example Problem' do
      add_problem :multiple_choice do
        set_question  'can you see this?'
        add_option    'yes'
        add_option    'no'
      end
      add_problem :match_answer do
        set_question  "what is an object?"
        should_match  '/data/i'
        should_match  '/objects/i'
      end
    end
  end
  
  context 'one quiz' do
    subject { Quiz.find 5 }
    its(:name) { should == 'Example Problem' }
    its(:inspect) { should == "<Quiz:Example Problem>" }
    it { should == Quiz.find(5) }
    it { should have(2).problems }
    it 'should yield both problems to each_problem' do
      problems = Array.new
      subject.each_problem { |problem| problems << problem }
      problems.should == subject.problems
    end
  end  
  
  describe 'multiple choice problem' do
    subject { Quiz.find(5).problems.first }
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
    end
  end
  
  describe 'match answer problem' do
    subject { Quiz.find(5).problems.last }
    its(:question) { should == 'what is an object?' }
  end
  
end

require 'spec_helper'
require 'app/models/quiz'

describe Quiz do

  before do
    Quiz.new 5, 'Example Problem' do
      add_problem do
        set_question  'can you see this?'
        add_option    'yes'
        add_option    'no'
      end
      add_problem do
        set_question  "what's 3*3"
        add_option    'five'
        add_option    'six'
        add_option    'nine'
        add_option    'fifteen'
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
  
  describe 'its first problem' do
    subject do
      Quiz.find(5).problems.first
    end
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
  
end

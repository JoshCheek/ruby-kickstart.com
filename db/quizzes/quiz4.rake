namespace :db do  
  task :populate => :quiz4
  task :quiz4 => :bootstrap do
    Quiz.add 4, 'Session 4 Quiz' do
      problem <<-PROBLEM, :mappings => { '(a)' => '&&', '(b)' => '||', '(c)' => '||', '(d)' => '&&' }, :presentation_order => %w[&& ||]
        Match the rules to the boolean operators!
        
            (a) If the left hand side is true, return the right hand side
            (c) If the left hand side is true, return the left hand side
            (d) If the left hand side is false, return the right hand side
            (b) If the left hand side is false, return the left hand side
      PROBLEM
      problem "This operator will assing a value, unless one has already been assigned.", :solution => 3, :options => %w[&&= && & ||= || |]
      problem "What does a range from 1 through 5 look like?", :match => /\b1\s*\.\.(\s*5|\.\s*6)\b/
      problem "Directory is a fancy word for folder.", :predicate => true
      add_problem :many_to_many do
        set_question <<-PROBLEM
          What are each of the following used for?
          
              (a) File.open filename, 'w'
              (b) File.read filename
              (c) File.readlines filename
              (d) File.foreach filename
        PROBLEM
        subproblem '(a)', 'Writing to a file.'
        subproblem '(a)', 'Reading in the file.'
        subproblem '(a)', 'Reading in the file as an array of lines.'
        subproblem '(a)', 'Iterating over each line in the file.'
        presentation_order [
          'Writing to a file.',
          'Reading in the file.',
          'Reading in the file as an array of lines.',
          'Iterating over each line in the file.',
        ].sort
      end
      problem "Use `File.dirname __FILE__` to", :solution => 1, :options => [
        'Get the working directory.',
        "Get the current file's directory.",
        "Get the current file.",
      ]
      problem "If you want to use prime numbers, you might be interested in mathn " \
              "from the standard library, which defines the `prime?` method on "    \
              "integers. How would you load mathn?", :solution => 0, :options => [
        '`require "mathn"`',
        '`import "mathn"`',
        '`include "mathn"`',
      ]
      problem "If you have two files, `filea.rb` and `fileb.rb` in the same directory, " \
              "how would `filea.rb` load `fileb.rb`?", :solution => 4, :options => [
        '`require "fileb"`',
        '`require "fileb.rb"`',
        '`require File.dirname(__FILE__) + "/fileb"`',
        '`require File.dirname(__FILE__) + "/fileb".rb`',
      ]
      problem "How would you define class A, which inherits from class B?", :match => /\bclass\s+A\s*<\s*B\b/
      problem "In the previous problem, which is the subclass and which is the superclass?", :mappings => { 'A' => 'subclass', 'B' => 'superclass' }, :presentation_order => %w[subclass superclass]
      problem "Subclasses inherit instance methods from their superclasses.", :predicate => true
      problem "Subclasses inherit class methods from their superclasses.", :predicate => true
      problem "What is overriding?", :solution => 1, :options => [
        'When you replace an existing method with a new one.',
        'When you define a method in a subclass that is already defined in the superclass.',
        'When you require a file that you have already required',
      ]
      problem "What's the easiest way to raise an exception?", :solution => 2, :options => [
        '`throw Exception.new("exception")`',
        '`raise Exception.new("exception")`',
        '`raise "exception"`',
      ]
      problem "How do you prevent an exception from killing your program?", :solution => 1, :options => [
        "You catch it",
        "Use begin/rescue/end",
        "Don't call code that could raise an exception.",
      ]
      problem <<-PROBLEM, :match => /"a"|'a'/
        Given a stack, what do you expect when you pop it?
        
            stack = Stack.new
            stack.push "a"
            stack.push "b"
            stack.pop
            stack.push "c"
            stack.pop
            stack.pop # => ?
      PROBLEM
    end
  end
end



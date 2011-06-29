namespace :db do  
  task :populate => :quiz4
  task :quiz4 => :bootstrap do
    Quiz.add 4, 'Session 4 Quiz' do
      problem <<-PROBLEM, :mappings => { '(a)' => "`&&`{: lang='ruby'}", '(b)' => "`||`{: lang='ruby'}", '(c)' => "`||`{: lang='ruby'}", '(d)' => "`&&`{: lang='ruby'}" }, :presentation_order => ["`&&`{:\ lang='ruby'}", "`||`{:\ lang='ruby'}"]
        Match the rules to the boolean operators!
        
        (a) If the left hand side is true, return the right hand side<br />
        (c) If the left hand side is true, return the left hand side<br />
        (d) If the left hand side is false, return the right hand side<br />
        (b) If the left hand side is false, return the left hand side<br />
      PROBLEM
      problem "This operator will assing a value, unless one has already been assigned.", :solution => 3, :options => ["`&&=`{: lang='ruby'}", "`&&`{: lang='ruby'}", "`&`{: lang='ruby'}", "`||=`{: lang='ruby'}", "`||`{: lang='ruby'}", "`|`{: lang='ruby'}"]
      problem "What does a range from 1 through 5 look like?", :match => /\b1\s*\.\.(\s*5|\.\s*6)\b/
      add_problem :many_to_many do
        set_question <<-PROBLEM
          What are each of the following used for?
          
          (a) `File.open filename, 'w'`{: lang='ruby'}
          (b) `File.read filename`{: lang='ruby'}
          (c) `File.readlines filename`{: lang='ruby'}
          (d) `File.foreach filename`{: lang='ruby'}
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
      problem "Directory is a fancy word for folder.", :predicate => true
      problem "Use `File.dirname(__FILE__)`{: lang='ruby'} to", :solution => 1, :options => [
        'Get the working directory.',
        "Get the current file's directory.",
        "Get the current file.",
      ]
      problem "If you want to use prime numbers, you might be interested in mathn " \
              "from the standard library, which defines the `prime?`{: lang='ruby'} method on "    \
              "integers. How would you load mathn?", :solution => 0, :options => [
        "`require \"mathn\"`{: lang='ruby'}",
        "`import \"mathn\"`{: lang='ruby'}",
        "`include \"mathn\"`{: lang='ruby'}",
      ]
      problem "If you have two files, `filea.rb`{: lang='ruby'} and `fileb.rb`{: lang='ruby'} in the same directory, " \
              "how would `filea.rb`{: lang='ruby'} load `fileb.rb`{: lang='ruby'}?", :solution => 2, :options => [
        "`require 'fileb'`{: lang='ruby'}",
        "`require 'fileb.rb'`{: lang='ruby'}",
        "`require File.dirname(__FILE__) + '/fileb'`{: lang='ruby'}",
        "`require File.dirname(__FILE__) + '/fileb.rb'`{: lang='ruby'}",
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
        "`throw Exception.new('exception')`{: lang='ruby'}",
        "`raise Exception.new('exception')`{: lang='ruby'}",
        "`raise 'exception'`{: lang='ruby'}",
      ]
      problem "How do you prevent an exception from killing your program?", :solution => 1, :options => [
        "User try/catch",
        "Use begin/rescue/end",
        "Don't call code that could raise an exception.",
      ]
      problem <<-PROBLEM, :match => /"a"|'a'/
        Given a stack, what do you expect when you pop it?
        
        {: lang='ruby'}
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



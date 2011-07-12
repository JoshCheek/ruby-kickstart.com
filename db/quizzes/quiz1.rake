namespace :db do  
  task :populate => :quiz1
  task :quiz1 => :bootstrap do
    Quiz.add 1, 'Session 1 Quiz' do
      problem 'What is a set of instructions called?', :match => /method/i
      problem "What does the dollar sign mean in cases like `$ ruby -v`", :solution => 3, :options => [
        'It means you get paid if the code works.',
        'It means you should be careful when using this code.',
        'It means you should enter this in your text editor.',
        'It means you should enter this at the command line',
      ]
      problem "What is `25 / 2`{: lang='ruby'}", :match => /^\b12\b*/
      problem "What is `25.0 / 2`{: lang='ruby'}", :match => /^\b12\.5\b/
      problem "What is `25.0 / 5`{: lang='ruby'}", :match => /^\b5\.0\b/
      problem 'What is an object? (looking for two words)', :match => [/\bdata\b/i, /\bmethods?\b/i]
      problem 'What do variables do?', :solution => 2, :options => [
        'They represent data and methods',
        'They change',
        'They point at objects',
      ]
      problem 'What is text called in Ruby?', :match => /\bstrings?\b/i
      problem 'If you are in the same directory as a ruby program, how do you run it?', :solution => 2, :options => [
        'double click it',
        '`$ prog.rb`',
        '`$ ruby prog.rb`',
        '`$ rb prog.rb`',
        '`$ run prog.rb`',
        '`$ execute prog.rb`',
      ]
      problem 'What does a method return?', :solution => 1, :options => ['nil', 'the result of the last instruction it evaluated', 'the last object evaluated', 'its parameters', 'itself']
      problem 'What does an empty method return?', :match => /\bnil\b/
      problem 'How should you indent?', :solution => 2, :options => ['With a tab', 'With a space', 'With two spaces', 'With four spaces', 'With eight spaces']
      problem 'Local variables can be seen across scope', :predicate => false
      problem 'How do you write local variables?', :solution => 0, :options => ['With snake_case', 'With CamelCase']
      problem 'How do you write constants?', :solution => 1, :options => ['With snake_case', 'With CamelCase']
      problem 'What are the two names for objects you pass to a method when you invoke it?', :match => [/\barguments?\b/i, /\bparameters?\b/i]
      problem "Which of these method invocations isn't valid?", :solution => 2, :options => [
        "`add(1, 2)`{: lang='ruby'}",
        "`add 1, 2`{: lang='ruby'}",
        "`add 1 2`{: lang='ruby'}",
      ]
      problem 'What does `puts("I want #{1 + 2} tacos")` print? (notice double quotes)', :solution => 1, :options => [
        'I want #{1 + 2} tacos',
        'I want 3 tacos',
        'I want 1 + 2 tacos',
      ]
      problem %q[What does `puts('I want #{1 + 2} tacos')` print? (notice single quotes)], :solution => 0, :options => [
        'I want #{1 + 2} tacos',
        'I want 3 tacos',
        'I want 1 + 2 tacos',
      ]
      problem 'What is the name of the method that turns an object into a string', :match => /\bto_s\b/
      problem "What is the difference between `==`{: lang='ruby'} and `=`{: lang='ruby'} ?", :solution => 2, :options => [
        'There is no difference',
        "`==`{: lang='ruby'} assigns a value and `=`{: lang='ruby'} checks for equality",
        "`=`{: lang='ruby'} assigns a value and `==`{: lang='ruby'} checks for equality",
      ]
      problem 'Which of the below are false?', :solution => 0, :options => %w[nil FalseClass 0 "false"]
      problem 'What does a 1 line if statement look like?', :solution => 0, :options => [
        "`code_to_evaluate if condition`{: lang='ruby'}",
        "`if condition; code_to_evaluate`{: lang='ruby'}",
        "`if(condition) code_to_evaluate`{: lang='ruby'}",
        "`if condition then code_to_evaluate`{: lang='ruby'}",
      ]
      problem "What is a more ruby way of saying `if !condition`{: lang='ruby'}?", :match => /\bunless\s*condition\b/i
      problem 'When several conditions of an if, elsif, else statement are all true, which ones are evaluated?', :solution => 1, :options => [
        'The first one',
        'The first true one',
        'The last true one',
        'All true ones',
        'All of them',
        'The else clause',
      ]
      problem 'How do you test your solutions to the challenges?', :solution => 3, :options => [
        "You don't",
        "`$ ruby filename.rb`",
        "`$ rake filename.rb`",
        "`$ rake session:challenge`",
        "`$ ruby session:challenge`",
      ]
      problem 'Given a number, `num`, write the condition that evaluates to true if num is 2 or 3.', 
        :match => %r{\bnum\s*==\s*2\s*\|\|\s*num\s*==\s*3\b|\bnum\s*==\s*3\s*\|\|\s*num\s*==\s*2\b|\b2\s*==\s*num\s*\|\|\s*3\s*==\s*num\b|\b3\s*==\s*num\s*\|\|\s*2\s*==\s*num\b}x
      problem %q(What does `!"abc"`{: lang='ruby'} evaluate to?), :match => /\bfalse\b/
      problem %q(What does `!!"abc"`{: lang='ruby'} evaluate to?), :match => /\btrue\b/
      problem %q(What does `"Jack and Jill".split`{: lang='ruby'} return?), :solution => 1, :options => [
        %q(`["J", "a", "c", "k", " ", "a", "n", "d", " ", "J", "i", "l", "l"]`{: lang='ruby'}),
        %q(`["Jack", "and", "Jill"]`{: lang='ruby'}),
        %q(A new copy of `"Jack and Jill"`{: lang='ruby'}),
      ]
      problem %q(What does `"Jack and Jill".split.length`{: lang='ruby'} return?), :match => /3|three/i
      problem %q(What does `"Jack and Jill".split.length.times { |i| puts i }`{: lang='ruby'} send to standard output?), :match => /\b0.*1.*2\b/
    end
  end  
end



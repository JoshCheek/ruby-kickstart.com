namespace :db do  
  task :populate => :quiz1
  task :quiz1 do
    Quiz.add 1, 'Session 1 Quiz' do
      problem 'What is a set of instructions called?', :match => /method/i
      problem 'What does the dollar sign mean in cases like `$ ruby -v`', :solution => 3, :options => [
        'It means you get paid if the code works.',
        'It means you should be careful when using this code.',
        'It means you should enter this in your text editor.',
        'It means you should enter this at the command line',
      ]
      problem 'What is `25 / 2`', :match => /^\s*(12)\s*/
      problem 'What is `25.0 / 2`', :match => /^\s*(12.5)\s*/
      problem 'What is `25.0 / 5`', :match => /^\s*(5.0)\s*/
      problem 'What is the suffix for ruby files?', :solution => 1, :options => %w(file.ruby file.rb file.exe file.rub)
      problem 'What is an object? (looking for two words)', :match => [/\bdata\b/i, /\bmethods?\b/i]
      problem 'What do variables do?', :solution => 2, :options => [
        'They represent data and methods',
        'They change',
        'They point at objects',
      ]
      problem 'What is text called in Ruby?', :match => /\bstrings?\b/i
      problem 'If you are in the same directory as a ruby program named prog.rb, how do you run it?', :solution => 2, :options => [
        'double click it',
        '`$ prog.rb`',
        '`$ ruby prog.rb`',
        '`$ rb prog.rb`',
        '`$ run prog.rb`',
        '`$ execute prog.rb`',
      ]
      problem 'What does a method return?', :solution => 1, :options => ['nil', 'its last instruction', 'the last object evaluated', 'its parameters', 'itself']
      problem 'What does an empty method return?', :match => /\bnil\b/
      problem 'How should you indent?', :solution => 2, :options => ['With a tab', 'With a space', 'With two spaces', 'With four spaces', 'With eight spaces']
      problem 'Can local variables be seen across scope?', :options => %w[yes no], :solution => 1
      problem 'How do you write local variables?', :solution => 0, :options => ['With snake_case', 'With CamelCase']
      problem 'How do you write constants?', :solution => 1, :options => ['With snake_case', 'With CamelCase']
      problem 'What are the two names for objects you pass to a method when you invoke it?', :match => [/\barguments?\b/i, /\bparameters?\b/i]
      problem 'How do you invoke a method named `add`, and pass it the numbers 1 and 2? (pick the best answer)', :solution => 6, :options => [
        '`add(1, 2)`',
        '`add(1 2)`',
        '`add 1, 2`',
        '`(add 1, 2)`',
        '`(add 1 2)`',
        'all of the above',
        '`add(1, 2)` or `add 1, 2`',
        '`add(1 2)` or `add 1 2`',
      ]
      problem 'What does `puts("I want #{1 + 2} tacos")` print?', :solution => 1, :options => [
        'I want #{1 + 2} tacos',
        'I want 3 tacos',
        'I want 1 + 2 tacos',
      ]
      problem %q[What does `puts('I want #{1 + 2} tacos')` print?], :solution => 0, :options => [
        'I want #{1 + 2} tacos',
        'I want 3 tacos',
        'I want 1 + 2 tacos',
      ]
      problem 'What is the name of the method that turns an object into a string', :match => /\bto_s\b/
      problem 'What is the difference between `==` and `=` ?', :solution => 2, :options => [
        'There is no difference',
        '`==` assigns a value and `=` checks for equality',
        '`=` assigns a value and `==` checks for equality',
      ]
      problem 'Which of the below are false?', :solution => 0, :options => %w[nil FalseClass 0 "false"]
      problem 'What does a 1 line if statement look like?', :solution => 0, :options => [
        '`code_to_evaluate if condition`',
        '`if condition; code_to_evaluate`',
        '`if(condition) code_to_evaluate`',
        '`if condition then code_to_evaluate`',
      ]
      problem 'What is a more ruby way of saying `if !condition`?', :match => /\bunless\s*condition\b/i
      problem 'When several conditions of an if, elsif, else statement are all true, which ones are evaluated?', :solution => 1, :options => [
        'The first one',
        'The first true one',
        'The last true one',
        'All true ones',
        'All of them',
        'The else clause',
      ]
    end
  end  
end



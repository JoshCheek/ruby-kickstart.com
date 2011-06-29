namespace :db do  
  task :populate => :quiz5
  task :quiz5 => :bootstrap do
    Quiz.add 5, 'Session 5 Quiz' do
      problem "You can't define methods in a module", :predicate => false
      problem "What is the maximum number of modules you can mix into a class?", :solution => 3, :options => ['0', '1', '5', 'there is no limit']
      problem "How do you mix a module into a class?", :match => /\binclud/i
      problem "How do you put a module's methods on an object?", :solution => 1, :options => [
        "Include it in the object's class.",
        "Include it in the object's singleton class.",
        "Subclass the module.",
      ]
      problem "Seeing a module in a list of ancestors lets us know that we will inherit the module's methods.", :predicate => true
      problem <<-PROBLEM, :solution => 1, :options => ["`my_obj.include MyModule`{: lang='ruby'}", "`my_obj.extend MyModule`{: lang='ruby'}", "`my_obj << MyModule`{: lang='ruby'}"]
        What is a shortcut syntax for this code?
        
        {: lang='ruby'}
            class << my_obj
              include MyModule
            end
      PROBLEM
      add_problem :multiple_choice do
        set_question  <<-PROBLEM
          In the code
          
          {: lang='ruby'}
              module Threes
                def threes_r0
                  select { |i| i % 3 == 0 }
                end
              end
          
          Where does `select`{: lang='ruby'} come from?
        PROBLEM
        add_option  'It is available in every module.'
        add_option  %q(It is defined on `self`{: lang='ruby'}, the object that invoked `threes_r0`{: lang='ruby'}.), :solution => true
        add_option  'It is the Ruby keyword that defines a select statement.'
      end
      problem <<-PROBLEM, :predicate => false
        In this code
        
        {: lang='ruby'}
            module Task
              class Dependency
              end
            end
            
            module Gem
              class Dependency
              end
            end
        
        `Task::Dependency`{: lang='ruby'} is the same as `Gem::Dependency`{: lang='ruby'}
      PROBLEM
      problem 'Which of the following is not a way to match regular expressions against strings?', :solution => 3, :options => [
        %q|`"String" =~ /S/`{: lang='ruby'}|,
        %q|`"String"[/S/]`{: lang='ruby'}|,
        %q|`"String".scan(/S/)`{: lang='ruby'}|,
        %q|`"String".search(/S/)`{: lang='ruby'}|,
      ]
      problem %q|What will `"bba bb bc bd be"[/\bb[aeiou]/]`{: lang='ruby'} return?|, :solution => 5, :options => %w[bba ba bb bc bd be]
      problem 'In regular expressions, the * matches any character except newlines.', :predicate => false
      problem 'In regular expressions, the . matches any character except newlines.', :predicate => true
      problem %q(What will `[/^./, /.$/].map { |regex| "a b"[regex] }`{: lang='ruby'} return?), :match => /\[\s*(['"])a\1\s*,\s*(['"])b\2\s*\]/
      problem %q(After matching a string against `/Name: (\w*)/`{: lang='ruby'}, how would you access the name?), :solution => 3, :options => [
        'It will be returned by the match function.',
        "Invoke `regex.name`{: lang='ruby'}.",
        "It will be stored in the `name`{: lang='ruby'} variable.",
        "It will be stored in the `$1`{: lang='ruby'} variable.",
        "It will be stored in the `$name`{: lang='ruby'} variable.",
      ]
      problem 'What is the name of the command line utility that you can use to manage your rubygems?', :match => /\bgem\b/
      problem 'If you wanted to use the mechanize gem, how would you load that code?', :solution => 0, :options => [
        %q(`require "mechanize"`{: lang='ruby'}),
        %q(`import "mechanize"`{: lang='ruby'}),
        %q(`include "mechanize"`{: lang='ruby'}) ,
      ]
      problem 'At the terminal, how do you install Sinatra?', :match => /\bgem\s+install\s+sinatra\b/
    end
  end
end



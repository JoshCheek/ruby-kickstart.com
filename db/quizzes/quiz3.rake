namespace :db do  
  task :populate => :quiz3
  task :quiz3 => :bootstrap do
    Quiz.add 3, 'Session 3 Quiz' do
      add_problem :many_to_many do
        set_question <<-PROBLEM
          List what each returns.
          
              :abc.class      # => (a)
              "abc".class     # => (b)
              'abc'.class     # => (c)
              123.class       # => (d)
              String.class    # => (e)
              [1,2,3].class   # => (f)
              {1=>23}.class   # => (g)
        PROBLEM
        subproblem '(a)', 'Symbol'
        subproblem '(b)', 'String'
        subproblem '(c)', 'String'
        subproblem '(d)', 'Fixnum'
        subproblem '(e)', 'Class'
        subproblem '(f)', 'Array'
        subproblem '(g)', 'Hash'
        presentation_order %w(Symbol String Fixnum Class Array Hash).sort
      end
      problem "`:abc.object_id == :abc.object_id`", :predicate => true
      problem "`'abc'.object_id == 'abc'.object_id`", :predicate => false
      problem <<-PROBLEM, :mappings => { '(a)' => ':ghi', '(b)' => 'nil', '(c)' => '789' }, :presentation_order => %w[:abc :def :ghi 123 456 789 nil]
        Select the values of a, b, and c that make the code accurate
      
            hash = { :abc => 123, :def => 456, :ghi => 789 }
            hash[(a)]   # => 789
            hash[456]   # => (b)
            hash[:ghi]  # => (c)
      PROBLEM
      problem 'If you are interested in a sequential list of objects, what data structure should you use?', :solution => 2, :options => %w[Hash String Array Set]
      problem 'How would you get an object that would always tell you the current time?', :solution => 2, :options => [
        'current_time = def time; Time.now; end',
        'current_time = Time.now',
        'current_time = Proc.new { Time.now }',
      ]
      problem <<-PROBLEM, :predicate => false
        This will raise an error.

            user = 'Sally'
            notify = Proc.new do
              "The current user is \#{user}"
            end
            notify.call
      PROBLEM
      problem <<-PROBLEM, :predicate => true
        This will raise an error.
        
            user = 'Sally'
            def notify
              "The current user is \#{user}"
            end
            notify
      PROBLEM
      problem 'How do methods receive blocks?', :solution => 2, :options => ['like any other parameter', 'by placing an *asterisk in front of the last parameter', 'by placing an &amp;ampersand in front of the last parameter']
      problem 'In the code `method { ... }`, the { ... } is placed into a special block slot for the method.', :predicate => true
      problem 'Use `{ ... }` to pass', :solution => 0, :options => ['inline blocks', 'multiline blocks']
      problem 'Use `do ... end` to pass', :solution => 1, :options => ['inline blocks', 'multiline blocks']
      problem 'In the method declaration `def method(&block)`, the block variable is set to an empty Proc, if method is invoked without a block.', :predicate => false
      problem 'Blocks can be stored in instance variables and then executed when something interesting happens.', :predicate => true
      add_problem :many_to_many do
        set_question <<-PROBLEM
          For a and b, how would you pass the block, given the signatures of `receiver1` and `receiver2`? For c and d, how would you invoke them?
        
              def caller(&block)
                receiver1 (a)
                receiver2 (b)
              end
            
              def receiver1(&block)
                (c)
              end
            
              def receiver2(block)
                (d)
              end
            
              caller { }
        PROBLEM
        subproblem '(a)', '&amp;block'
        subproblem '(b)', 'block'
        subproblem '(c)', 'block.call'
        subproblem '(d)', 'block.call'
        presentation_order %w[block block.call &amp;block block()]
      end
      problem <<-PROBLEM, :mappings => { '(a)' => 'ordinal', '(b)' => 'optional', '(c)' => 'variable length', '(d)' => 'block' }, :presentation_order => %w[ordinal optional variable\ length block].sort
        Associate the parameter type with the signature.
        
            # (a)
            def meth(param)
            end
            
            # (b)
            def meth(param = 1)
            end
            
            # (c)
            def meth(*param)
            end
            
            # (d)
            def meth(&param)
            end
      PROBLEM
    end
  end
end



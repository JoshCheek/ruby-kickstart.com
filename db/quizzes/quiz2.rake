namespace :db do  
  task :populate => :quiz2
  task :quiz2 => :bootstrap do
    Quiz.add 2, 'Session 2 Quiz' do
      problem 'What is an ordered list of objects called?', :match => /\barrays?\b/i
      problem %q(If `array = ['zero', 'one', 'two']`{: lang='ruby'}, then what does `array[1]`{: lang='ruby'} return?),  :solution => 1, :options => [%q(`"zero"`{: lang='ruby'}), %q(`"one"`{: lang='ruby'}), %q(`"two"`{: lang='ruby'}), %q(`"nil"`{: lang='ruby'})]
      problem %q(If `array = ['zero', 'one', 'two']`{: lang='ruby'}, then what does `array[-1]`{: lang='ruby'} return?), :solution => 2, :options => [%q(`"zero"`{: lang='ruby'}), %q(`"one"`{: lang='ruby'}), %q(`"two"`{: lang='ruby'}), %q(`"nil"`{: lang='ruby'})]
      problem %q(If `array = ['zero', 'one', 'two']`{: lang='ruby'}, then what does `array[10]`{: lang='ruby'} return?), :solution => 3, :options => [%q(`"zero"`{: lang='ruby'}), %q(`"one"`{: lang='ruby'}), %q(`"two"`{: lang='ruby'}), %q(`"nil"`{: lang='ruby'}), %q(it raises an error)]
      problem 'If you have a big array', :solution => 2, :options => [
        'it is faster to access the first element than the last',
        'it is faster to access the last element than the first',
        'it is just as fast to access the first element as the last'
      ]
      problem 'What method iterates over an array?', :match => /\beach\b/
      problem "`array.map`{: lang='ruby'} modifies `array`{: lang='ruby'}", :predicate => false
      problem 'What operator appends an item to the end of an array?', :match => /<<|double\s*chevron/i
      problem 'What method sorts an array?', :match => /\bsort!?\b/i
      problem 'Why do we need classes?', :solution => 1, :options => [
        'to keep track of data',
        'to define objects',
        'to run methods',
      ]
      problem 'Classes are', :solution => 2, :options => [
        'methods',
        'containers for objects',
        'containers for methods',
        'lists of methods',
      ]
      problem "Given a class, `Pirate`{: lang='ruby'}, instantiate it", :match => /\bPirate\s*\.\s*new\b/
      problem "`String`{: lang='ruby'}, `Array`{: lang='ruby'}, and `Fixnum`{: lang='ruby'} are examples of", :solution => 3 , :options => %w[variables primitives methods classes containers]
      problem %q(When we say `"abc".length`{: lang='ruby'}, where is the length method stored?), :solution => 2, :options => [
        %Q(in `"abc"`{: lang='ruby'}),
        %q[in `"abc"`{: lang='ruby'}'s singleton class],
        "in the `String`{: lang='ruby'} class"
      ]
      problem 'Between Planet and Mars, which is the class?', :solution => 0, :options => %w[Planet Mars]
      problem "When you see something that begins with an `@asperand`{: lang='ruby'}, you know it is a[n]", :match => /\binstance.*\bvariable\b/i
      problem <<-PROBLEM, :match => /attr_accessor\s+(:value|'value'|"value")/
        What is another way of defining these methods?
        
        {: lang='ruby'}
            def value=(value)
              @value = value
            end
            
            def value
              @value
            end
      PROBLEM
      problem %q(When you write `event.time = "11:00"`{: lang='ruby'}), :solution => 1, :options => [
        "You are invoking `event`{: lang='ruby'}'s `time`{: lang='ruby'} method",
        "You are invoking `event`{: lang='ruby'}'s `time=`{: lang='ruby'} method",
        "You are setting `event`{: lang='ruby'}'s `@time`{: lang='ruby'} instance variable",
        "You are setting `event`{: lang='ruby'}'s `time`{: lang='ruby'} attribute",
      ]
      problem 'How do you give an object its initial state?', :solution => 1, :options => [
        "Put it in the `new`{: lang='ruby'} method",
        "Put it in the `initialize`{: lang='ruby'} method",
        'Pass the appropriate state to its setters after instantiating it',
      ]
      add_problem :many_to_many do
        set_question <<-PROBLEM
          What is `self` in each case?
          
          {: lang='ruby'}
            self # => (a)
            class Klass
              self # => (b)
            
              class << self
                self # => (c)
                def method
                  self # => (d)
                end
              end
            
              class << Klass
                self # => (e)
              end
            
              def method
                self # => (f)
              end
            end
        PROBLEM
        subproblem '(a)' , 'main'
        subproblem '(b)' , 'Klass'
        subproblem '(c)' , "Klass' singleton class"
        subproblem '(d)' , 'Klass'
        subproblem '(e)' , "Klass' singleton class"
        subproblem '(f)' , 'Instances of Klass'
        presentation_order ['Class', 'Klass', "Klass' singleton class", "nil", "main", "Object", 'Instances of Klass']
      end
      problem 'A method can see instance variables set in other methods in the same class', :predicate => true
      problem 'A method can see local variables set in other methods in the same class', :predicate => false
      problem "Where are the class' methods stored that are shared by all classes?", :match => /\bClass\b/i
      problem "Where are the class' methods stored that are unique to the class?", :match => /\bsingleton\b.*\bclass/i
      problem <<-PROBLEM, :mappings => { '(a)' => 'Klass.method', '(b)' => 'Klass.new.method' , '(c)' => 'Klass.method' }, :presentation_order => %w[Klass.method Klass.new.method]
        How do you invoke each of the methods below?
        
        {: lang='ruby'}
            # (a)
            class Klass
              def self.method
              end
            end
                          
            # (b)
            class Klass
              def method
              end
            end
            
            # (c)
            class << Klass
              def method
              end
            end
      PROBLEM
    end
  end
end



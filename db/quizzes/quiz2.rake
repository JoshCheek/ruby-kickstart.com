namespace :db do  
  # task :populate => :quiz2
  task :quiz2 => :bootstrap do
    Quiz.add 2, 'Session 2 Quiz' do
      problem 'What is an ordered list of objects called?', :match => /\barrays?\b/i
      problem %q(If `array = ['zero', 'one', 'two']`, then what does `array[1]` return?), :solution => 1, :options => %w[zero one two nil]
      problem %q(If `array = ['zero', 'one', 'two']`, then what does `array[-1]` return?), :solution => 3, :options => %w[zero one two nil]
      problem %q(If `array = ['zero', 'one', 'two']`, then what does `array[10]` return?), :solution => 2, :options => %w[zero one two nil]
      problem 'If you have a big array', :solution => 2, :options => [
        'it is faster to access the first element than the last',
        'it is faster to access the last element than the first',
        'it is just as fast to access the first element as the last'
      ]
      problem 'What method iterates over an array?', :match => /\beach\b/
      problem 'array.map modifies array', :predicate => false
      problem 'What operator appends an item to the end of an array?', :match => /<<|double chevron/i
      problem 'What method sorts an array?', :match => /\bsort!?\b/i
      problem 'Why do we need classes?', :match => [/define|describe|specify/i, /objects?/i]
      problem 'Classes are', :solution => 2, :options => [
        'methods',
        'containers for objects',
        'containers for methods',
        'lists of methods',
      ]
      problem 'Given a class, Pirate, instantiate it', :match => /\bPirate.new\b/
      problem 'String, Array, and Fixnum are examples of', :solution => 3 , :options => %w[variables primitives methods classes containers]
      problem 'When we say `"abc".length`, where is the length method stored?', :solution => 2, :options => [
        'in "abc"',
        %q[in "abc"'s singleton class],
        'in the String class'
      ]
      problem 'Between Planet and Mars, which is the class?', :solution => 0, :options => %w[Planet Mars]
      problem "Where are class' methods stored?", :match => /\bsingleton\b.*\bclass\b/i
      problem "When you see something that begins with an @asperand, you know it is a", :match => /\binstance.*\bvariable\b/i
      problem <<-PROBLEM, :match => /attr_accessor :value/
        What is another way of defining these methods?
        def value=(value)
          @value = value
        end
        def value
          @value
        end
      PROBLEM
      problem 'When you write `event.time = "11:00"`', :solution => 1, :options => [
        "You are invoking event's time method",
        "You are invoking event's time= method",
        "You are setting event's @time instance variable",
        "You are setting event's time attribute",
      ]
      problem 'How do you give an object its initial state?', :solution => 1, :options => [
        'Put it in the `new` method',
        'Put it in the `initialize` method',
        'Pass the appropriate state to its setters after instantiating it',
      ]
      problem <<-PROBLEM, :lhs => %w[(a) (b) (c) (d) (e) (f)], :rhs => ['main', 'Klass', "Klass' singleton class", 'Instances of Klass', 'Class', 'nil' ]
        What is `self` in each case?
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
      problem 'A method can see instance variables set in other methods in the same class', :predicate => true
      problem 'A method can see local variables set in other methods in the same class', :predicate => true
      problem 'How do you define a method on a class?', :match => /\bsingleton\b.*\bclass/i
      problem <<-PROBLEM, :solution => 0, :options => %w[Klass.method Klass.new.method]
        How do you invoke the method below?
        class Klass
          def method
          end
        end
      PROBLEM
      
    end
  end
end



Quiz = Class.new



class << Quiz
  
  attr_accessor :quizzes
  
  def find n
    @quizzes[n] || raise("There is no quiz ##{n}")
  end

  def add n, quiz
    @quizzes[n] = quiz
  end
  
end
Quiz.quizzes = Hash.new



class Quiz
  
  attr_accessor :name, :problems

  def initialize n, name, &block
    self.name = name
    self.problems = Array.new
    Quiz.add n, self
    instance_eval &block
  end
  
  def add_problem type, &block
    problem_class = case type
      when :match_answer    then MatchAnswerProblem
      when :multiple_choice then MultipleChoiceProblem
      else raise "#{type} is not a valid problem type"
    end
    self.problems << problem_class.new(&block)
  end
  
  def inspect
    "<Quiz:#{name}>"
  end
  
  def each_problem
    problems.each do |problem|
      yield problem
    end
  end
  
end



class Quiz  
  class MultipleChoiceProblem < Struct.new(:question, :options)
    
    alias_method :set_question, :question=
    
    def initialize &block
      super()
      self.options = Array.new
      instance_eval &block if block
    end
    
    def add_option option
      options << option
    end
    
    def each_option
      options.each_with_index do |option, index|
        yield index.next, option
      end
    end
    
  end
end



class Quiz
  class MatchAnswerProblem < Struct.new(:question, :regexes)
    
    alias_method :set_question, :question=
    
    def initialize &block
      super()
      self.regexes = Array.new
      instance_eval &block if block
    end
    
    def should_match regex
      regexes << regex
    end
    
  end
end
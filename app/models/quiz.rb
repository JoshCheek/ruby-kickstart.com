class Quiz < ActiveRecord::Base
  
  def self.add n, name, &block
    quiz = Quiz.create :name => name , :number => n
    quiz.instance_eval &block if block
    quiz
  end
  
  has_many :quiz_problems
  validates_uniqueness_of :number
  
  def add_problem type, &block
    problem_class = case type
      when :match_answer    then QuizMatchAnswerProblem
      when :multiple_choice then QuizMultipleChoiceProblem
      else raise "#{type} is not a valid problem type"
    end
    problem = problem_class.new
    problem.instance_eval &block
    QuizProblem.create :problemable => problem , :quiz => self
  end
  
  def inspect
    "<Quiz:#{name}>"
  end
  
  def problems
    quiz_problems.map &:problemable
  end
  
  def each_problem &block
    problems.each &block
  end
  
  def problem question, options
    if match_answer_problem? options
      add_match_answer(question, options[:match])
    elsif multiple_choice_problem? options
      add_multiple_choice(question, options[:solution], options[:options])
    end
  end

private

  def match_answer_problem? options
    !!options[:match]
  end
  
  def multiple_choice_problem? options
    !!options[:options]
  end
  
  def add_match_answer _question, regexes
    add_problem :match_answer do
      self.question = _question
      regexes.each { |regex| should_match regex }
    end
  end
  
  def add_multiple_choice _question, solution_index, options
    add_problem :multiple_choice do
      self.question = _question
      options.each_with_index do |option, index|
        is_solution = (index == solution_index)
        add_option option, :solution => is_solution
      end
    end
  end
    
end

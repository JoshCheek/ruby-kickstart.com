class Quiz < ActiveRecord::Base
  
  def self.add n, name, &block
    quiz = Quiz.create :name => name , :number => n
    quiz.instance_eval &block if block
    quiz
  end
  
  has_many :quiz_problems, :order => :position
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
  
  def each_problem_with_index &block
    quiz_problems.each do |quiz_problem|
      block.call quiz_problem.problemable, quiz_problem.position
    end
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
      Array(regexes).each { |regex| should_match regex }
    end
  end
  
  def add_multiple_choice _question, solution_index, options
    add_problem :multiple_choice do
      self.question = _question
      options.each_with_index do |option, index|
        add_option option, :solution => (index == solution_index)
      end
    end
  end
    
end

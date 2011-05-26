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
  
  def problem _question, options
    if options[:match]
      add_problem :match_answer do
        self.question = _question
        options[:match].each { |regex| should_match regex }
      end
    elsif options[:options]
      add_problem :multiple_choice do
        self.question = _question
        options[:options].each_with_index do |option, index|
          add_option option, :solution => (index == options[:solution])
        end
      end
    end
  end
    
end

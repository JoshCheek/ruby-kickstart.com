class Quiz < ActiveRecord::Base
  
  def self.add n, name, &block
    quiz = Quiz.create :name => name , :number => n
    quiz.instance_eval &block
  end
  
  has_many :quiz_problems
  
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
    
end

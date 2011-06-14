class QuizManyToManySolution < ActiveRecord::Base
    
  has_one :quiz_solution, :as => :solutionable
  
  before_save { self.serialized_solution = YAML.dump answers }
  
  def quiz_problem
    quiz_solution.quiz_problem
  end
  
  def problem
    quiz_problem.problemable
  end
    
  def solve(answers)
    self.answers = answers
  end
  
  attr_writer :answers
  
  def answers
    @answers ||= YAML.load serialized_solution
  end
  
  def for(question)
    answers[question]
  end
  
  def guessed?(q, a)
    answers[q] == a
  end
  
  def score
    problem.score_for answers
  end
  
end

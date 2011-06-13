class QuizPredicateSolution < ActiveRecord::Base
  
  has_one :quiz_solution, :as => :solutionable
  
  def quiz_problem
    quiz_solution.quiz_problem
  end
  
  def problem
    quiz_problem.problemable
  end  
  
  def solve(answer)
    if 0 == answer || "0" == answer || false == answer || nil == answer
      self.answer = false
    else
      self.answer = true
    end
  end
  
  def correct?
    answer == problem.predicate
  end
  
  def score
    return (correct? ? 1 : 0), 1
  end
  
end

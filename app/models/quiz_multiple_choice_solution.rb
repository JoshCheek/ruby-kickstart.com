class QuizMultipleChoiceSolution < ActiveRecord::Base
  has_one :quiz_solution, :as => :solutionable
  
  def quiz_problem
    quiz_solution.quiz_problem
  end
  
  def problem
    quiz_problem.problemable
  end
  
  def solve(answer)
    self.answer = answer
  end

  def correct?
    problem.solution_id.to_s == answer
  end

end

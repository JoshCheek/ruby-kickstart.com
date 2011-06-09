class QuizMultipleChoiceSolution < ActiveRecord::Base
  has_one :quiz_solution, :as => :solutionable
  
  def solve(answer)
    self.answer = answer
  end
end

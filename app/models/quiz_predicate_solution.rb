class QuizPredicateSolution < ActiveRecord::Base
  
  def solve(answer)
    if 0 == answer || "0" == answer || false == answer || nil == answer
      self.answer = false
    else
      self.answer = true
    end
  end
    
end

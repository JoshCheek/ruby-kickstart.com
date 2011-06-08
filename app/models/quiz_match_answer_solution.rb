class QuizMatchAnswerSolution < ActiveRecord::Base
  def solve(answer)
    self.answer = answer
  end
end
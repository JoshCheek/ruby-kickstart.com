class QuizPredicateProblem < ActiveRecord::Base
  
  has_many  :quiz_problems , :as => :problemable
  has_many  :quizzes , :through => :quiz_problems
  
  def set_question(question)
    self.question = question
  end
  
  def expect(boolean)
    self.predicate = !!boolean
  end
  
end
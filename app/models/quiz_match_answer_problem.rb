class QuizMatchAnswerProblem < ActiveRecord::Base

  has_many  :regexes , :dependent => :destroy , :class_name => '::QuizRegex'
  has_many  :quiz_problems , :as => :problemable
  has_many  :quizzes , :through => :quiz_problems
  
  def set_question(question)
    self.question = question
  end
    
  def should_match regex
    regexes.build :content => regex
  end
  
end

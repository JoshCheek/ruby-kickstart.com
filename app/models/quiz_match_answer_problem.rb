class QuizMatchAnswerProblem < ActiveRecord::Base

  has_many  :quiz_regexes , :dependent => :destroy
  has_many  :quiz_problems , :as => :problemable
  has_many  :quizzes , :through => :quiz_problems
  
  def set_question(question)
    self.question = question
  end
    
  def should_match(regex)
    quiz_regexes.build :regex => regex
  end
  
  def each_regex
    quiz_regexes.each do |quiz_regex|
      yield quiz_regex.regex
    end
  end
  
end

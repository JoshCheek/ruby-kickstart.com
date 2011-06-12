class QuizMultipleChoiceProblem < ActiveRecord::Base

  has_many    :quiz_options , :dependent => :destroy
  has_many    :quiz_problems , :as => :problemable
  has_many    :quizzes , :through => :quiz_problems
  belongs_to  :solution , :class_name => 'QuizOption', :autosave => true
   
  def set_question(question)
    self.question = question
  end
    
  def add_option(body='', options={})
    option = quiz_options.build :body => body
    self.solution = option if options[:solution]
  end
  
  def options
    quiz_options.map(&:body)
  end
  
end

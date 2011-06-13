class QuizMultipleChoiceProblem < ActiveRecord::Base

  has_many    :quiz_problems , :as => :problemable
  has_many    :quizzes , :through => :quiz_problems
   
  def set_question(question)
    self.question = question
  end
    
  def add_option(body='', method_options={})
    options << body
    self.solution = body if method_options[:solution]
  end
  
  def options
    @options ||= if new_record?
      []
    else
      YAML.load serialized_options
    end
  end
  
  def correct?(answer)
    answer == solution
  end
  
  before_save do
    self.serialized_options = YAML.dump options
  end
  
end

class QuizRegex < ActiveRecord::Base
  
  belongs_to :quiz_match_answer_problem
  
  def content=(regex)
    super YAML.dump(regex)
  end
  
  def content
    YAML.load(super)
  end
  
end
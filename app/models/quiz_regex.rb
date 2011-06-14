class QuizRegex < ActiveRecord::Base
  
  belongs_to :quiz_match_answer_problem
  
  def regex=(regex)
    @regex = regex
    self.content = YAML.dump regex
  end
  
  def regex
    @regex ||= YAML.load(content)
  end
  
end
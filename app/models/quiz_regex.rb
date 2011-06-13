class QuizRegex < ActiveRecord::Base
  
  belongs_to :quiz_match_answer_problem
  
  def regex=(regex)
    @regex = regex
    self.content = Marshal.dump regex
  end
  
  def regex
    @regex ||= Marshal.load(content)
  end
  
end
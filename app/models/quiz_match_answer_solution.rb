class QuizMatchAnswerSolution < ActiveRecord::Base
  
  has_one :quiz_solution, :as => :solutionable
  
  def quiz_problem
    quiz_solution.quiz_problem
  end
  
  def problem
    quiz_problem.problemable
  end
      
  def solve(answer)
    self.answer = answer
  end
  
  def correct?
    each_regex { |regex| return false unless regex =~ answer }
    true
  end
  
  def score
    return (correct? ? 1 : 0), 1
  end
  
  def each_regex(&block)
    problem.each_regex(&block)
  end
  
  def failure_explanation
    return '' if correct?
    regexes = []
    each_regex do |regex|
      next if regex =~ answer
      regexes << regex.inspect
    end
    "Expected to match #{regexes.join ', '}, but didn't."
  end
  
end
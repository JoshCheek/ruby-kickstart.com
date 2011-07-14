class QuizSolution < ActiveRecord::Base
  
  belongs_to :quiz_taken
  belongs_to :quiz_problem
  belongs_to :solutionable, :polymorphic => true, :autosave => true
  has_one    :quiz, :through => :quiz_taken
  validates_associated  :solutionable
  validates_presence_of :solutionable
  validates_presence_of :quiz_problem
  
  def problem
    raise 'Expected a quiz_problem' unless quiz_problem
    quiz_problem.problemable
  end
  
  def solve(solution)
    select_solutionable.solve solution
  end
  
  def select_solutionable
    self.solutionable ||= case problem
    when QuizMatchAnswerProblem
      QuizMatchAnswerSolution.new
    when QuizMultipleChoiceProblem
      QuizMultipleChoiceSolution.new
    when QuizPredicateProblem
      QuizPredicateSolution.new
    when QuizManyToManyProblem
      QuizManyToManySolution.new
    else
      raise "unexpected error :/"
    end
    solutionable
  end
  
end
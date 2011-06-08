class QuizTaken < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many   :quiz_solutions
  
  validates_presence_of :user
  validates_presence_of :quiz
  validates_associated  :quiz_solutions

  
  def quiz_problems
    quiz && quiz.quiz_problems
  end
    
  def apply_solutions(solutions={})
    quiz_solutions = quiz_solutions.to_a
    quiz_problems.each_with_index do |quiz_problem, index|
      solution = solutions[index] || solutions[index.to_s]
      next unless solution
      quiz_solution = quiz_solutions.build :quiz_problem => quiz_problem
      quiz_solution.solve solution
    end
    save
  end
  
end
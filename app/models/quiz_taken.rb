class QuizTaken < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many   :quiz_solutions
  
  validates_presence_of :user
  validates_presence_of :quiz
  validates_associated  :quiz_solutions

  after_initialize do |quiz_taken|
    quiz_problems.each do |quiz_problem|
      quiz_solutions.build :quiz_problem => quiz_problem
    end
  end

  
  def quiz_problems
    quiz && quiz.quiz_problems
  end
    
  def apply_solutions(solutions={})
    solutions.each do |id , solution|
      quiz_solution = quiz_solutions.detect {|s| s.quiz_problem_id == id}
      quiz_solution.solve solution if quiz_solution
    end
    save
  end
  
end
class QuizTaken < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many   :quiz_solutions
  
  def quiz_problems
    quiz && quiz.quiz_problems
  end
  
  after_initialize do |quiz_taken|
    quiz_problems.each do |quiz_problem|
      quiz_solutions.build :quiz_problem => quiz_problem
    end
  end
  
end
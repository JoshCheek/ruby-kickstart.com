class QuizSolution < ActiveRecord::Base
  belongs_to :quiz_taken
  belongs_to :quiz_problem
  belongs_to :solutionable, :polymorphic => true
end
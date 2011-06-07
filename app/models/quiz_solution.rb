class QuizSolution < ActiveRecord::Base
  belongs_to :quiz_taken
  belongs_to :quiz_problem
  belongs_to :solutionable, :polymorphic => true
  has_one    :quiz, :through => :quiz_taken
  has_one    :user, :through => :quiz_taken
end
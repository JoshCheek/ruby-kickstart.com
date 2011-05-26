class QuizProblem < ActiveRecord::Base
  belongs_to :problemable, :polymorphic => true
  belongs_to :quiz
end
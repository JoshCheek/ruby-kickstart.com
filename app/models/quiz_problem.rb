class QuizProblem < ActiveRecord::Base
  default_scope order(:position)
  belongs_to :problemable, :polymorphic => true
  belongs_to :quiz
  acts_as_list :scope => :quiz_id
end
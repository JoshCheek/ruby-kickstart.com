class QuizProblem < ActiveRecord::Base
  belongs_to :problemable, :polymorphic => true
  belongs_to :quiz
  acts_as_list :scope => :quiz_id
  validates_uniqueness_of :position, :scope => :quiz_id
end
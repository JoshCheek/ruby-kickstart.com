class QuizTaken < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many :quiz_solutions
end
class CreateQuizMatchAnswerProblem < ActiveRecord::Migration
  def self.up
    create_table :quiz_match_answer_problems do |t|
      t.string :question
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_match_answer_problems
  end
end

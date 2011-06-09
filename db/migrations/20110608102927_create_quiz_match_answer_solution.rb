class CreateQuizMatchAnswerSolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_match_answer_solutions do |t|
      t.text :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_match_answer_solution
  end
end
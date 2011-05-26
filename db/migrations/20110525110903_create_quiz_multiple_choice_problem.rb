class CreateQuizMultipleChoiceProblem < ActiveRecord::Migration
  def self.up
    create_table :quiz_multiple_choice_problems do |t|
      t.string :question
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_multiple_choice_problems
  end
end

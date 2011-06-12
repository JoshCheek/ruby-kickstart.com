class CreateQuizMultipleChoiceSolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_multiple_choice_solutions do |t|
      t.text :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_multiple_choice_solutions
  end
end
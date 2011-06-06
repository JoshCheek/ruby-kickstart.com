class CreateQuizSolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_solutionsdo do |t|
      t.references :user
      t.references :quiz
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_solutions
  end
end
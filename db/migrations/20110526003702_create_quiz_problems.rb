class CreateQuizProblems < ActiveRecord::Migration
  def self.up
    create_table :quiz_problems do |t|
      t.references :quiz
      t.references :problemable, :polymorphic => true
      t.integer    :order
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_problem
  end
end

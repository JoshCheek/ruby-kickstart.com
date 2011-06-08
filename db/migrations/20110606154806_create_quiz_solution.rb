class CreateQuizSolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_solutions do |t|
      t.references :quiz_taken
      t.references :solutionable, :polymorphic => true
      t.references :quiz_problem
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_solutions
    raise ActiveRecord::IrreversibleMigration
  end
end
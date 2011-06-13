class CreateQuizManyToManyProblem < ActiveRecord::Migration
  def self.up
    create_table :quiz_many_to_many_problems do |t|
      t.string :question
      t.binary :serialized_data
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_many_to_many_problems
    raise ActiveRecord::IrreversibleMigration
  end
end
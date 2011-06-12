class CreateQuizManyToManySolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_many_to_many_solutions do |t|
      t.binary :serialized_solution
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_many_to_many_solutions

  end
end
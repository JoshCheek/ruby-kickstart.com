class CreateQuizPredicateSolution < ActiveRecord::Migration
  def self.up
    create_table :quiz_predicate_solutions do |t|
      t.boolean :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_predicate_solutions
  end
end
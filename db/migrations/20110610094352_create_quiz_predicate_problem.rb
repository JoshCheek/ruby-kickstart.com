class CreateQuizPredicateProblem < ActiveRecord::Migration
  def self.up
    create_table :quiz_predicate_problems do |t|
      t.text    :question
      t.boolean :predicate
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_predicate_problem
  end
end
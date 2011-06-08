class CreateQuizOptions < ActiveRecord::Migration
  def self.up
    create_table :quiz_options do |t|
      t.string :body
      t.references :quiz_multiple_choice_problem
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_options
  end
end

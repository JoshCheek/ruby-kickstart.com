class UpdateQuizMultipleChoice < ActiveRecord::Migration
  def self.up    
    drop_table :quiz_options
    remove_column :quiz_multiple_choice_problems, :solution_id
    add_column    :quiz_multiple_choice_problems, :solution, :text    
    add_column    :quiz_multiple_choice_problems, :serialized_options, :text
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
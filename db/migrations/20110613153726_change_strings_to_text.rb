class ChangeStringsToText < ActiveRecord::Migration
  def self.up
    change_column :quiz_many_to_many_problems, :question, :text
    change_column :quiz_regexes, :content, :text
  end

  def self.down
    change_column :quiz_regexes, :content, :string
    change_column :quiz_many_to_many_problems, :question, :string
  end
end

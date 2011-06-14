class SwitchSerializationToYaml < ActiveRecord::Migration
  def self.up
    change_column :quiz_many_to_many_problems     , :serialized_data      , :text , :limit => nil
    change_column :quiz_many_to_many_solutions    , :serialized_solution  , :text , :limit => nil
    change_column :quiz_multiple_choice_problems  , :serialized_options   , :text , :limit => nil
    change_column :quiz_regexes                   , :content              , :text , :limit => nil
  end
  
  def self.down
    change_column :quiz_regexes                   , :content              , :binary
    change_column :quiz_multiple_choice_problems  , :serialized_options   , :binary
    change_column :quiz_many_to_many_solutions    , :serialized_solution  , :binary        
    change_column :quiz_many_to_many_problems     , :serialized_data      , :binary
  end
end

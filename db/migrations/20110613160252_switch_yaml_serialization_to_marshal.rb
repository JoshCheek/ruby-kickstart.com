class SwitchYamlSerializationToMarshal < ActiveRecord::Migration
  def self.up
    change_column :quiz_multiple_choice_problems, :serialized_options, :binary
    change_column :quiz_regexes, :content, :binary, :limit => nil # because it used to be a string and will retain its limit otherwise
  end

  def self.down
    change_column :quiz_regexes, :content, :text
    change_column :quiz_multiple_choice_problems, :serialized_options, :text
  end
end

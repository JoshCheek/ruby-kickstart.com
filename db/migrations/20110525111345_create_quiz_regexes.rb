class CreateQuizRegexes < ActiveRecord::Migration
  def self.up
    create_table :quiz_regexes do |t|
      t.string :content
      t.references :quiz_match_answer_problem
      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_regexes
  end
end

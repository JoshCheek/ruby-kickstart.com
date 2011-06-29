class AddQuizVersioning < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :version, :integer
  end

  def self.down
    remove_column :quizzes, :version
  end
end
class AddQuizVersioning < ActiveRecord::Migration
  
  Quiz = Class.new ActiveRecord::Base
  
  def self.up
    add_column :quizzes, :version, :integer
    Quiz.all.each { |quiz| quiz.version = 1; quiz.save }
  end

  def self.down
    remove_column :quizzes, :version
  end
  
end
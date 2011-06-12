class QuizManyToManyProblem < ActiveRecord::Base
  
  class Subproblems
    attr_accessor :question_set, :answer_set, :mappings
    def initialize
      @question_set  =  []
      @answer_set    =  nil
      @mappings      =  {}
    end
    def add(q, a)
      @question_set << q
      @mappings[q] = a
    end
    def valid?
      @mappings.all? do |question, answer|
        @question_set.include?(question) && @answer_set.include?(answer)
      end
    end
  end
  
  
  
  def valid?(*args)
    subproblems.valid?
  end
  
  after_initialize do
    @subproblems = if new_record?
      Subproblems.new
    else
      Marshal.load(serialized_data)
    end
  end
  
  before_save do
    self.serialized_data = Marshal.dump subproblems
  end
  
  attr_accessor :subproblems
  
  def set_question(question)
    self.question = question
  end
  
  def subproblem(q, a)
    subproblems.add q, a
  end
  
  def presentation_order(answer_set)
    subproblems.answer_set = answer_set
  end
  
  def question_set
    subproblems.question_set
  end
  
  def solution_set
    subproblems.answer_set
  end
      
end
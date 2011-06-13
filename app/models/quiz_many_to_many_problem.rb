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

    def assert_valid_as_problems!
      @mappings.each do |question, answer|
        raise "#{question} is not in #@question_set"  unless @question_set.include?(question)
        raise "#{answer} is not in #@answer_set"      unless @answer_set.include?(answer)
      end
    end
    
    def correct?(q, a)
      @mappings[q] == a
    end
    
    def score_for(answers)
      numerator = denominator = 0
      answers.each do |q, a|
        numerator += 1 if correct? q, a
        denominator += 1
      end
      [numerator, denominator]
    end

  end

  
  has_many  :quiz_problems , :as => :problemable
  has_many  :quizzes , :through => :quiz_problems
  
  
  def valid?(*args)
    subproblems.assert_valid_as_problems!
    true
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
  
  def guessed_correct?(q, a)
    subproblems.correct?(q, a)
  end
  
  def score_for(answers)
    subproblems.score_for answers
  end
  
  alias_method :correct?, :guessed_correct?
  
end

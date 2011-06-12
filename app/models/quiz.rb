class Quiz < ActiveRecord::Base
  
  def self.add(n, name, &block)
    quiz = Quiz.create :name => name , :number => n
    quiz.instance_eval &block if block
    quiz
  end
  
  has_many :quiz_problems, :order => :position
  validates_uniqueness_of :number
  
  def add_problem(type, &block)
    problem_class = case type
      when :match_answer    then QuizMatchAnswerProblem
      when :multiple_choice then QuizMultipleChoiceProblem
      when :predicate       then QuizPredicateProblem
      when :many_to_many    then QuizManyToManyProblem
      else raise "#{type} is not a valid problem type"
    end
    problem = problem_class.new
    problem.instance_eval &block
    QuizProblem.create :problemable => problem , :quiz => self
  end
  
  def inspect
    "<Quiz:#{name}>"
  end
  
  def problems
    quiz_problems.map &:problemable
  end
  
  def each_problem(&block)
    problems.each &block
  end
  
  def each_problem_with_index(&block)
    quiz_problems.each do |quiz_problem|
      block.call quiz_problem.problemable, quiz_problem.position
    end
  end
  
  def each_id_problem_and_index(&block)
    quiz_problems.each do |quiz_problem|
      block.call quiz_problem.id, quiz_problem.problemable, quiz_problem.position
    end
  end
  
  def problem(question, options)
    if match_answer_problem? options
      add_match_answer(question, options[:match])
    elsif multiple_choice_problem? options
      add_multiple_choice(question, options[:solution], options[:options])
    elsif predicate_problem? options
      add_predicate(question, options[:predicate])
    elsif many_to_many_problem? options
      add_many_to_many(question, options[:mappings], options[:presentation_order])
    else
      raise "Don't know what to do with question:#{question.inspect}, options:#{options.inspect}"
    end
  end

private

  def many_to_many_problem?(options)
    options.has_key? :mappings
  end

  def match_answer_problem?(options)
    options.has_key? :match
  end
  
  def multiple_choice_problem?(options)
    options.has_key? :options
  end
  
  def predicate_problem? options
    options.has_key? :predicate
  end
  
  def add_many_to_many(_question, mappings, order)
    add_problem :many_to_many do
      self.question = _question
      mappings.each do |q, a|
        subproblem q, a
      end
      presentation_order order
    end
  end
  
  def add_predicate(_question, predicate)
    add_problem :predicate do
      self.question = _question
      expect !!predicate
    end
  end
  
  def add_match_answer(_question, regexes)
    add_problem :match_answer do
      self.question = _question
      Array(regexes).each { |regex| should_match regex }
    end
  end
  
  def add_multiple_choice(_question, solution_index, options)
    add_problem :multiple_choice do
      self.question = _question
      options.each_with_index do |option, index|
        add_option option, :solution => (index == solution_index)
      end
    end
  end
    
end

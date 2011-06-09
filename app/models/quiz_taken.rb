class QuizTaken < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
  has_many   :quiz_solutions
  
  validates_presence_of :user
  validates_presence_of :quiz
  validates_associated  :quiz_solutions

  after_initialize do |quiz_taken|
    if new_record?
      quiz_problems.each do |quiz_problem|
        quiz_solutions.build :quiz_problem => quiz_problem
      end
    end
  end

  def quiz_problems
    quiz && quiz.quiz_problems
  end
  
  def solutions
    quiz_solutions.map(&:solutionable)
  end  
    
  def apply_solutions(solutions={})
    solutions.each do |id , solution|
      quiz_solution = quiz_solutions.detect do |soln|
        soln.quiz_problem_id == id || soln.quiz_problem_id.to_s == id
      end
      quiz_solution.solve solution if quiz_solution
    end
    save
  end
  
  def each_problem_with_solution_and_index &block
    quiz_solutions.each_with_index do |solution, index|
      block.call solution.problem, solution.solutionable, index.next
    end
  end
  
  def name
    quiz.name
  end
  
  def summary
    correct = total = 0
    solutions.each do |solution|
      correct += 1 if solution.correct?
      total += 1
    end
    "#{correct} / #{total}"
  end
  
end
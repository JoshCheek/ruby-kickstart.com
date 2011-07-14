require File.join(File.dirname(__FILE__),'bootstrap')


helpers do
      
  def messages
    @messages ||= begin
      hash = Hash.new
      hash[:error] = session.delete :error if session[:error]
      hash
    end
  end
  
  def h(*args)
    ERB::Util.h *args
  end
  
  def without_leading_whitepace(string)
    string.gsub(/^        /,'')
  end
  
  def doing_maintenance?
    'true' == ENV['DOING_MAINTENANCE']
  end
  
  def inline_markdown(text)
    markdown(text, :layout => false).sub(/^\s*<p\s*>/,'').sub(/<\/p\s*>\s*$/,'')
  end
  
end


before do
  @quizzes = [
    Quiz.find_latest(1),
    Quiz.find_latest(2),
    Quiz.find_latest(3),
    Quiz.find_latest(4),
    Quiz.find_latest(5),
    Quiz.find_latest(6),
  ].compact
end

get '/' do
  haml :home
end

get '/about' do
  @title = 'About Ruby Kickstart'
  haml :about
end
 
  
get '/quizzes/:quiz_number' do
  @quiz = Quiz.find_latest params[:quiz_number]
  @title = @quiz.name
  haml :quiz
end

post '/quizzes/:quiz_number' do  
  quiz = Quiz.find_latest params[:quiz_number]
  quiz_taken = QuizTaken.new :quiz => quiz
  quiz_taken.apply_solutions params[:quiz_results]
  raise "something went wrong with the quiz submission :/" if quiz_taken.new_record?
  redirect "/quiz_results/#{quiz_taken.id}"
end

get '/quiz_results/:quiz_id' do
  @quiz_taken = QuizTaken.find params[:quiz_id]
  @title = @quiz_taken.name
  haml :quiz_results
end

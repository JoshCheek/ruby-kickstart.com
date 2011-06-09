require File.join(File.dirname(__FILE__),'bootstrap')
require 'erb'

helpers do
  
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def restricted(message, landing_page='/')
    unless logged_in?
      session[:error] = message
      redirect landing_page
    end
  end
  
  def extract_messages
    @messages = Hash.new
    @messages[:error] = session.delete :error if session[:error]
  end
  
  def h *args
    ERB::Util.h *args
  end
  
end


get '/' do
  extract_messages
  haml :home
end
 
  
get '/quizzes/:quiz_number' do
  restricted 'You must be logged in to take quizzes.'
  @quiz = Quiz.find_by_number params[:quiz_number]
  haml :quiz
end

post '/quizzes/:quiz_number' do  
  restricted 'You must be logged in to submit quizzes'
  @quiz = Quiz.find_by_number params[:quiz_number]
  @quiz_taken = QuizTaken.new :quiz => @quiz, :user => current_user
  @quiz_taken.apply_solutions params[:quiz_results]
  haml :quiz_results
end

get '/auth/:name/callback' do
  auth = request.env["omniauth.auth"]
  user = User.find_by_uid(auth["uid"])
  user ||= User.create  :uid      => auth["uid"], 
                        :provider => params[:name],
                        :name     => auth["user_info"]["name"]
  session[:user_id] = user.id
  redirect '/'
end


%w[/sign_in/? /sign-in/? /signin/? 
   /log_in/?  /log-in/?  /login/?
   /sign_up/? /sign-up/? /signup/?].each do |path|
  get path do
    redirect '/auth/twitter'
  end
end


%w[/sign_out /signout /log_out /logout /log-out /sign-out].each do |path|
  get path do
    session[:user_id] = nil
    redirect '/'
  end
end

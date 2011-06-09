require File.join(File.dirname(__FILE__),'bootstrap')


helpers do
  
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
end


get '/' do
  haml :home
end
 
  
get '/quizzes/:quiz_number' do
  if logged_in?
    @quiz = Quiz.find_by_number params[:quiz_number].to_i
    haml :quiz
  else
    session[:notice] = 'You must be logged in to take quizzes.'
    redirect '/'
  end
end

post '/quizzes/:quiz_number' do
  require 'erb'
  ERB::Util.h params.inspect
end

get '/quiz1' do
  @quiz = Quiz.find_by_number(1)
  haml :quiz
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

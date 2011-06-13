require File.join(File.dirname(__FILE__),'bootstrap')


helpers do
  
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    @current_user = session[:user_id] = nil
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
  
end


configure :development, :test do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
end


before do
  @quizzes = Quiz.all :order => :number
end

get '/' do
  haml :home
end

get '/about' do
  haml :about
end
 
  
get '/quizzes/:quiz_number' do
  restricted 'You must be logged in to take quizzes.'
  @quiz = Quiz.find_by_number params[:quiz_number]
  haml :quiz
end

post '/quizzes/:quiz_number' do  
  restricted 'You must be logged in to submit quizzes'
  quiz = Quiz.find_by_number params[:quiz_number]
  quiz_taken = QuizTaken.new :quiz => quiz, :user => current_user
  quiz_taken.apply_solutions params[:quiz_results]
  raise "something went wrong with the quiz submission :/" if quiz_taken.new_record?
  redirect "/quiz_results/#{quiz_taken.id}"
end

get '/quiz_results' do
  restricted 'You must be logged in to view your quizzes.'
  @quiz_takens = current_user.quiz_takens
  haml :quizzes
end

get '/quiz_results/:quiz_id' do
  restricted 'You must be logged in to view your results'
  @quiz_taken = QuizTaken.find params[:quiz_id]
  if @quiz_taken.user != current_user
    session[:error] = "You can only view your own quizzes."
    redirect '/quiz_results'
  end
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
    redirect '/auth/facebook'
  end
end


%w[/sign_out /signout /log_out /logout /log-out /sign-out].each do |path|
  get path do
    session[:user_id] = nil
    redirect '/'
  end
end

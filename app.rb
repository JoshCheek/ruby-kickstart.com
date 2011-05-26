require File.join(File.dirname(__FILE__),'environment')

get '/' do
  haml :home
end


get '/quiz1' do
  @quiz = Quiz.find(1)
  haml :quiz
end
require File.join(File.dirname(__FILE__),'bootstrap')

get '/' do
  haml :home
end


get '/quiz1' do
  @quiz = Quiz.find_by_number(1)
  haml :quiz
end
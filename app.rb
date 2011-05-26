require File.join(File.dirname(__FILE__),'environment')

get '/' do
  haml :home
end

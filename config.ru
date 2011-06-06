require File.dirname(__FILE__) + "/app"

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :twitter,  'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end

run Sinatra::Application
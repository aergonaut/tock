require './app'
require 'rack/ssl'

$stdout.sync = true

use Rack::SSL
use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV['TOCK_USER'] and password == ENV['TOCK_PASSWORD'] 
end

run Tock::App

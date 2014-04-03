require './app'
$stdout.sync = true

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV['TOCK_USER'] and password == ENV['TOCK_PASSWORD'] 
end

run Tock::App

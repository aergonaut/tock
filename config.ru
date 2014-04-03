require './app'
$stdout.sync = true

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'admin' and password == 'admin'
end

run Tock::App

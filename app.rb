require 'sinatra/base'

module Tock
  class App < Sinatra::Base

    get '/' do
      # show the current number
    end

    get '/increment' do
      # increment the number and return it
    end

  end
end

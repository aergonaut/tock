require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'redis'
require 'json'

module Tock
  class App < Sinatra::Base

    configure :development do
      register Sinatra::Reloader
    end

    get '/', :provides => :html do
      current_number = redis.get("number") || 0
      haml :index, :locals => { :current_number => current_number }
    end

    get /\A\/(?:current)?\Z/, :provides => :json do
      current_number = redis.get("number") || 0
      note = redis.get("note") || ""
      json "current" => current_number, "note" => note
    end

    post '/increment' do
      request.body.rewind
      parsed_body = JSON.parse(request.body.read)
      new_note = parsed_body.fetch("note", "")

      current = redis.get("number") || 0
      current = current.to_i + 1
      redis.set("number", current)
      redis.set("note", new_note)
      json "current" => current.to_s, "note" => new_note
    end

    protected

    def redis
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end

  end
end

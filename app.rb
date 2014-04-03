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

    get /\A\/(?:current)?\Z/, :provides => :html do
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
      body = request.body.read
      parsed_body = JSON.parse(body)
      new_note = parsed_body.fetch("note", "")

      current = redis.incr("number")
      redis.set("note", new_note)
      redis.rpush("note_log", "#{current}: #{new_note}")
      json "current" => current.to_s, "note" => new_note
    end

    post '/reset' do
      request.body.rewind
      parsed_body = JSON.parse(request.body.read)
      old_number = redis.get("number")
      new_number = parsed_body.fetch("number",0).to_i
      redis.rpush("note_log", "#{old_number} --> reset to #{new_number}")
      redis.set("number", new_number)
    end

    protected

    def redis
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end

  end
end

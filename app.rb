require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'redis'
require 'json'
require 'uri'
require 'net/http'
require 'net/https'

module Tock
  class App < Sinatra::Base

    configure :development do
      register Sinatra::Reloader
    end
    get '/:current?', :provides => :html do
      current_number = redis.get("number") || 0
      note_log = redis.lrange('note_log', 0, -1)
      other_numbers_keys = redis.keys("number.*")
      other_number_values = Array(other_numbers_keys).inject({}) { |m,o| m[o] = redis.get(o); m }
      haml :index, :locals => { :current_number => current_number,
                                :note_log => note_log.reverse,
                                :other_keys => other_numbers_keys,
                                :other_values => other_number_values }
    end

    get '/:current?', :provides => :json do
      current_number = redis.get("number") || 0
      note_log = redis.lrange('note_log', 0, -1)
      other_numbers_keys = redis.keys("number.*")
      other_number_values = Array(other_numbers_keys).inject({}) { |m,o| m[o] = redis.get(o); m }
      json "current" => current_number, "note_log" => note_log.reverse,
           "other_keys" => other_numbers_keys, "other_values" => other_number_values
    end

    post '/increment' do
      request.body.rewind
      body = request.body.read
      parsed_body = JSON.parse(body)
      new_note = parsed_body.fetch("note", "")
      key = (parsed_body["key"].to_s.size > 0) ? "number.#{parsed_body["key"]}" : "number"

      current = redis.incr(key)
      redis.set("note", new_note)
      note_log "#{key=='number' ? current : "#{key.split('.').last} #{current}"}: #{new_note}"
      json "current" => current.to_s, "note" => new_note
    end

    post '/reset' do
      request.body.rewind
      parsed_body = JSON.parse(request.body.read)
      key = (parsed_body["key"].to_s.size > 0) ? "number.#{parsed_body["key"]}" : "number"

      old_number = redis.get(key)
      new_number = parsed_body.fetch("number", 0).to_i
      note_log "#{key} #{old_number} --> reset to #{new_number}"
      redis.set(key, new_number)
    end

    protected

    def note_log str
      redis.rpush("note_log", str)
    end

    def redis
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    end

  end
end

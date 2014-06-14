require 'sinatra'
require 'sinatra/json'
require 'json'

require 'mongoid'

set :environment, ENV['RACK_ENV'].to_s.to_sym

Mongoid.load!('./mongoid.yml')
enable :sessions

require_relative './lib/mongoid_as_json.rb'
require_relative './models/user.rb'
require_relative './models/contact.rb'

class AddressApi < Sinatra::Application
  def find_user id
    User.find(id)
  rescue Mongoid::Errors::DocumentNotFound => e
    nil
  end

  # Create user
  post '/api/v1/users' do
    data = JSON.parse(request.body.read) rescue {}
    user = User.create(data['user'])

    if user.valid?
      status 201
      json user.as_json
    else
      status 422
      json errors: user.errors
    end
  end

  # Read user
  get '/api/v1/users/:id' do
    response_status, response_body = 404, {error: "Couldn't find user with supplied id"}

    if user = find_user(params[:id])
      response_status, response_body = 200, user.as_json
    end

    status response_status
    json response_body
  end

  # Update user
  put '/api/v1/users/:id' do
    response_status, response_body = 404, {error: "Couldn't find user with supplied id"}
    data = JSON.parse(request.body.read) rescue {}

    if user = find_user(params[:id])
      if user.update_attributes(data['user'])
        response_status, response_body = 200, user.as_json
      else
        response_status, response_body = 422, {errors: user.errors}
      end
    end

    status response_status
    json response_body
  end

  # Delete user
  delete '/api/v1/users/:id' do
    response_status, response_body = 404, {error: "Couldn't find user with supplied id"}

    if user = find_user(params[:id])
      if user.destroy
        response_status, response_body = 200, {}
      else
        response_status, response_body = 500, {errors: user.errors}
      end
    end

    status response_status
    json response_body
  end

  # List contacts
  get '/api/v1/users/:id/contacts' do
    response_status, response_body = 404, {error: "Couldn't find user with supplied id"}

    if user = find_user(params[:id])
      response_status, response_body = 200, {contacts: user.contacts.as_json}
    end

    status response_status
    json response_body
  end
end

require 'spec_helper'
require 'json'
require 'bson'

feature "Users API", type: :feature do
  background do
    @user = User.create(name: 'Test User', email: 'test@user.com')
  end

  def json_put path, hash
    put path, hash.to_json, {"CONTENT_TYPE" => "application/json"}
  end

  def json_post path, hash
    post path, hash.to_json, {"CONTENT_TYPE" => "application/json"}
  end

  context 'Create User' do
    scenario 'valid user' do
      json_post '/api/v1/users', user: {name: 'New User', email: 'new.user@email.com'}
      body = JSON.parse(last_response.body)

      expect(last_response.status).to eq 201
      expect(body).to include 'name' => 'New User', 'email' => 'new.user@email.com'
      expect(BSON::ObjectId.legal?(body['id'])).to eq true
    end

    scenario 'invalid user' do
      json_post '/api/v1/users', user: {}

      expect(last_response.status).to eq 422
      expect(JSON.parse(last_response.body)).to have_key 'errors'
    end
  end

  context 'Read User' do
    scenario 'valid user' do
      get "/api/v1/users/#{@user.id}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to include 'name' => @user.name, 'email' => @user.email
    end

    scenario 'non existing user' do
      get '/api/v1/users/99999'
      expect(last_response.status).to eq 404
    end
  end

  context 'Update User' do
    scenario 'valid user' do
      json_put "/api/v1/users/#{@user.id}", user: {name: 'Updated Test User', email: 'updated@email.com'}

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to include 'name' => 'Updated Test User', 'email' => 'updated@email.com'
    end

    scenario 'non existing user' do
      json_put '/api/v1/users/99999', user: {name: 'Updated Test User', email: 'updated@email.com'}
      expect(last_response.status).to eq 404
    end
  end

  context 'Delete User' do
    scenario 'valid user' do
      delete "/api/v1/users/#{@user.id}"

      expect(last_response.status).to eq 200
      expect(last_response.body).to eq "{}"
    end

    scenario 'non existing user' do
      delete '/api/v1/users/99999'
      expect(last_response.status).to eq 404
    end
  end
end

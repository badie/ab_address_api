require 'spec_helper'
require 'json'

feature "Users API", type: :feature do
  background do
    @user = User.create(name: 'Test User', email: 'test@user.com')
  end

  context 'Create User' do
    scenario 'valid user' do
      post '/api/v1/users', user: {name: 'New User', email: 'new.user@email.com'}

      expect(last_response.status).to eq 201
      expect(JSON.parse(last_response.body)).to include 'id' => an_instance_of(Fixnum), 'name' => 'New User', 'email' => 'new.user@email.com'
    end

    scenario 'invalid user' do
      post '/api/v1/users', user: {}

      expect(last_response.status).to eq 422
      expect(JSON.parse(last_response.body)).to have_key 'errors'
    end
  end

  context 'Read User' do
    scenario 'valid user' do
      get "/api/v1/users/#{@user.id}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to include 'id' => an_instance_of(Fixnum), 'name' => @user.name, 'email' => @user.email
    end

    scenario 'non existing user' do
      get '/api/v1/users/99999'
      expect(last_response.status).to eq 404
    end
  end

  context 'Update User' do
    scenario 'valid user' do
      put "/api/v1/users/#{@user_id}", user: {name: 'Updated Test User', email: 'updated@email.com'}

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to include 'id' => an_instance_of(Fixnum), 'name' => 'Updated Test User', 'email' => 'updated@email.com'
    end

    scenario 'non existing user' do
      put '/api/v1/users/99999', user: {name: 'Updated Test User', email: 'updated@email.com'}
      expect(last_response.status).to eq 404
    end
  end

  context 'Delete User' do
    scenario 'valid user' do
      delete "/api/v1/users/#{@user_id}"

      expect(last_response.status).to eq 200
      expect(last_response.body).to eq ""
    end

    scenario 'non existing user' do
      delete '/api/v1/users/99999'
      expect(last_response.status).to eq 404
    end
  end
end

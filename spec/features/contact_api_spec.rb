require 'spec_helper'
require 'json'

feature "Contacts API", type: :feature do
  background do
    @user = User.create(name: 'Test User', email: 'test@user.com')
  end

  context 'List Contacts' do
    scenario 'valid user' do
      get "/api/v1/users/#{@user.id}/contacts"
      json = JSON.parse(last_response.body)

      expect(last_response.status).to eq 200
      expect(json).to have_key 'users'
      expect(json['users']).to be_a Array
    end

    scenario 'non existing user' do
      get '/api/v1/users/99999/contacts'
      expect(last_response.status).to eq 404
    end
  end
end

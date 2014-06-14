require 'sinatra'
require 'mongoid'

Mongoid.load!('./mongoid.yml')

set :environment, :production
enable :sessions

require_relative './models/user.rb'
require_relative './models/contact.rb'


class AddressApi < Sinatra::Application
end

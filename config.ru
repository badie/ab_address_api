require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require :default

require_relative "./address_api"
$stdout.sync = true

run AddressApi

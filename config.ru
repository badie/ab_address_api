require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require :default

ENV['RACK_ENV'] ||= :development

require_relative "./address_api"
$stdout.sync = true


run AddressApi

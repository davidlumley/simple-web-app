#!/usr/bin/env rackup
require File.expand_path("../config/boot", __FILE__)

if ENV['SENTRY_DSN']
  use Raven::Rack
end

map '/assets' do
  require 'sprockets'
  environment = Sprockets::Environment.new
  environment.append_path Assets::Javascripts::LOAD_PATH
  environment.append_path Assets::Stylesheets::LOAD_PATH
  run environment
end

map '/' do
  use Rack::LiveReload unless ENV['RACK_ENV'] == 'production'
  run SinatraApp::App
end
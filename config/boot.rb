ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, ENV['RACK_ENV'].to_sym)
Dir.glob(File.expand_path('../initializers/**/*.rb', __FILE__), &method(:require))
Dir.glob(File.expand_path('../../app/app**', __FILE__), &method(:require))

DataMapper.setup(:default, (ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/#{ENV['RACK_ENV']}.sqlite3"))
Dir.glob(File.expand_path('../../app/models/**', __FILE__), &method(:require))
DataMapper.auto_upgrade!

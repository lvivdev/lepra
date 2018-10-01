#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :main
end

get '/main' do
  erb :main
end

get '/new' do
  erb :new
end

post '/new' do
	content = params[:content]
	erb "You typed: #{content}"
end
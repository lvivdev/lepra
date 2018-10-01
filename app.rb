#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'lepra.db'
	@db.results_as_hash = true
end

before do  
	init_db
end

configure do
	init_db
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		created_date DATE,
		content TEXT
	)'
end

get '/' do
  erb :index
end

get '/index' do
	@results = @db.execute 'select * from Posts order by desc'
	
	erb :index
end

get '/new' do
  erb :new
end

post '/new' do
	content = params[:content]
	if content.length <= 0
		@error = 'Type text'
		return erb :new		
	end
#сохранение введенных данных в базу данных
	@db.execute 'insert into Posts (content, created_date) values (?, datetime())', [content]
	erb "You typed: #{content}"
end
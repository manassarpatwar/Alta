require 'erb'
require 'sinatra'
require 'sqlite3'
require 'twitter'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
  config = {
    :consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
    :consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX',
    :access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
    :access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
  }
  @client = Twitter::REST::Client.new(config)
  
end

#Set up database
before do 
	@db = SQLite3::Database.new './taxi_database.sqlite'
end

get '/complaint' do
  	#erb :complaint

	id = @db.execute("SELECT count(*) FROM Complaints") #Broken needs fixing (1)
    journey_id = 1113
	user_id = "uo3987e3894734"
	date_time = Time.now.strftime("%d/%m/%Y %H:%M").to_s
	complaint = "Your service is rubbish" #Change to be inputted from erb (2)
	
	"<h1>#{@id}</h1>"

    #@db.execute("INSERT INTO Complaints VALUES (?,?,?,?,?)", id, journey_id, user_id, date_time, complaint)
end


require 'erb'
require 'sinatra'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

include ERB::Util

before do
	@db = SQLite3::Database.new('./taxi_database.sqlite')
end

get '/add' do
	@submitted = false
	erb :addTaxi
end

post '/add' do
	@submitted = true

	# sanitize values
	@regNum = params[:regNum].strip
	@contact = params[:contact].strip
	@taxiType = params[:taxiType].strip.upcase

	# perform validation
	@regNum_ok = !@regNum.nil? && @regNum != ""
	@contact_ok = !@contact.nil? && @contact != ""
	if @taxiType == "S" || @taxiType == "M" || @taxiType == "L"
		@taxiType_ok = true
	else
		@taxiType_ok = false
	end
	
	@all_ok = @regNum_ok && @contact_ok && @taxiType_ok	

	count = @db.get_first_value('SELECT COUNT(*) FROM taxis')
	@id = count + 1

  	# add data to the database
	if @all_ok
    	# do the insert
		@db.execute('INSERT INTO taxis VALUES (?, ?, ?, ?)', [@id, @regNum, @contact, @taxiType])
  	end
	erb :addTaxi
end



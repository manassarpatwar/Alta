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
	erb :add
end

post '/add' do
	@submitted = true

	# sanitize values
	@id = params[:id].strip
	@name = params[:name].strip
	@dateTime = params[:dateTime].strip
	@userType = params[:userType].strip
	@freeRide = params[:freeRide].strip

	# perform validation
	@id_ok = !@id.nil? && @id != ""
	@name_ok = !@name.nil? && @name != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	@userType_ok = @userType = "1" || @userType = "0"
	@freeRide_ok = isPositiveNumber?(@freeRide)

	#count = @db.get_first_value('SELECT COUNT(*) FROM cities WHERE city = ? AND country = ?', [@city, @country])
	#@unique = (count == 0)
	
	@all_ok = @city_ok && @name_ok && @dateTime_ok && @userType_ok && @freeRide_ok

  	# add data to the database
	if @all_ok
    	# do the insert
		@db.execute('INSERT INTO users VALUES (?, ?, ?, ?, ?)', [@id, @name, @dateTime, @userType.to_i, @freeRide.to_i])
  	end
	erb :add
end

def isPositiveNumber? string
	if Integer(string) rescue false
		if string.to_i >= 0
			return true
		else
			return false
		end
	else
		return false
	end
end

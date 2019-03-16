require 'erb'
require 'sinatra'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

include ERB::Util

before do
	@db = SQLite3::Database.new('./editDatabase.sqlite')
end

get '/add' do
	@submitted = false
	erb :add
end

post '/add' do
	@submitted = true

	# sanitize values
	@city = params[:city].strip
	@country = params[:country].strip
	@population = params[:population].strip

	# perform validation
	@city_ok = !@city.nil? && @city != ""
	@population_ok = @population =~ /^[0-9]*$/
	count = @db.get_first_value('SELECT COUNT(*) FROM cities WHERE city = ? AND country = ?', [@city, @country])
	@unique = (count == 0)
	
	@all_ok = @city_ok && @population_ok && @unique

  	# add data to the database
	if @all_ok
    	# get next available ID
		id = @db.get_first_value 'SELECT MAX(id)+1 FROM cities';

    	# do the insert
		@db.execute('INSERT INTO users VALUES (?, ?, ?, ?)', [id, @city, @country, @population])
  	end
	erb :add
end

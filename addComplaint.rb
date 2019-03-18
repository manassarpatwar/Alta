require 'erb'
require 'sinatra'
require 'sqlite3'

set :bind, '0.0.0.0' # needed if you're running from Codio

before do
	@db = SQLite3::Database.new('./taxi_database.sqlite')
end

get '/' do
	@submitted = false
	erb :addComplaint
end

post '/add' do
	@submitted = true

	# sanitize values
	@journey_id = params[:journey_id]
    @user_id = params[:user_id]
    @date_time = Time.now.strftime("%d/%m/%Y %H:%M").to_s
	@complaint = params[:complaint]
    

	# perform validation
	@journey_id_ok = isPositiveNumber?(@journey_id)
    @complaint_ok = !@complaint.nil? && @complaint != ""
	
	@all_ok = @journey_id_ok && @complaint_ok	

	count = @db.get_first_value('SELECT COUNT(*) FROM complaints')
	@id = count

  	# add data to the database
	if @all_ok
    	# do the insert
		@db.execute('INSERT INTO complaints VALUES (?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @complaint])
  	end
	erb :addComplaint
end

def isPositiveNumber? string
	begin
		Float(string)
		int = string.to_i 
		puts "Not fail"
		if int >= 0
			return true
		else
			return false
		end
	rescue 
		puts "fail"
		return false
	end
end



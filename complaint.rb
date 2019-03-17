#--------------------Get Methods--------------------#
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


#--------------get analytics---------------#
require 'date'

get '/analytics' do
    redirect '/index' unless session[:admin]
    
    date = Array.new()
            
    x = 49

    while x >= 0
      time = ((DateTime.now - x).strftime("%Y/%m/%d").to_s)
      date.push(time)
      x -= 7
    end
    
    # Get total statistics currently from the database
	@howManyUsers = $db.exec("SELECT COUNT(*) FROM users").map{|x| x.values}
	@howManyJourneys = $db.exec("SELECT COUNT(*) FROM journeys").map{|x| x.values}
	@howManyFeedbacks = $db.exec("SELECT COUNT(*) FROM feedback").map{|x| x.values}
	@howManyTaxis = $db.exec("SELECT COUNT(*) FROM taxis").map{|x| x.values}
    
    # creates hashes and retrieves data by date about the change of user/journey/feedbck/taxi statistics
    @userData = Hash.new()
    @journeyData = Hash.new()
    @feedbackData = Hash.new()
    @taxiData = Hash.new()
    
    @userData = get_data("users", "signup_date", date)
    @journeyData = get_data("journeys", "date_time", date)
    @feedbackData = get_data("feedback", "date_time", date)

    @taxiData["Total Number"] = @howManyTaxis
    @taxiData["Sheffield"] = $db.exec("SELECT COUNT(*) FROM taxis WHERE city LIKE 'Sheffield'").map{|x| x.values}
    @taxiData["Manchester"] = $db.exec("SELECT COUNT(*) FROM taxis WHERE city LIKE 'Manchester'").map{|x| x.values}
    
    erb :analytics
end

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

	@howManyUsers = $db.execute("SELECT COUNT(*) FROM users") #WHERE signup_date < '13/03/2019' OR signup_date LIKE '13/03/2019%'
	@howManyJourneys = $db.execute("SELECT COUNT(*) FROM journeys")
	@howManyFeedbacks = $db.execute("SELECT COUNT(*) FROM feedback")
	@howManyTaxis = $db.execute("SELECT COUNT(*) FROM taxis")
    @userData = Hash.new()
    @journeyData = Hash.new()
    @feedbackData = Hash.new()
    @taxiData = Hash.new()
    
    date.each_with_index do |time, index|
      many = $db.execute("SELECT COUNT(*) FROM users WHERE signup_date < '#{time}' OR signup_date LIKE '#{time}%'")
      @userData[time] = many.to_s.slice(2..-3).to_i
    end

    date.each_with_index do |time, index|
      many = $db.execute("SELECT COUNT(*) FROM journeys WHERE date_time < '#{time}' OR date_time LIKE '#{time}%'")
      @journeyData[time] = many.to_s.slice(2..-3).to_i
    end
    
    date.each_with_index do |time, index|
      many = $db.execute("SELECT COUNT(*) FROM feedback WHERE date_time < '#{time}' OR date_time LIKE '#{time}%'")
      @feedbackData[time] = many.to_s.slice(2..-3).to_i
    end
     
    @taxiData["Total Number"] = @howManyTaxis
    @taxiData["Sheffield"] = $db.execute("SELECT COUNT(*) FROM taxis WHERE city LIKE 'Sheffield'") 
    @taxiData["Manchester"] = $db.execute("SELECT COUNT(*) FROM taxis WHERE city LIKE 'Manchester'") 
    
    
    
    erb :analytics
end

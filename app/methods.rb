def gather_taxis(city)
     @availableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS '#{city}' AND available IS "1"} #Gather all taxis
     @unavailableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS '#{city}' AND available IS "0"} #Gather all taxis
end

def add_feedback(j_id, u_id, fdbk, rat)
  	#get feedback table from the database
    @feedbackInfo = $db.execute("SELECT * FROM feedback")

    @submitted = true

    #sanitize values
    @journey_id = j_id
    @user_id = u_id
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    @feedback = fdbk
    @rating = rat

    # perform validation
    @journey_id_ok = isPositiveNumber? (@journey_id)
    @feedback_ok = !@feedback.nil? && @feedback != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""
    @rating_ok = @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'


    @all_ok = @journey_id_ok && @feedback_ok && @user_id_ok && @rating_ok

    @id = @feedbackInfo[@feedbackInfo.length-1][0].to_i + 1

    # add data to the database
    if @all_ok
        # do the insert
        $db.execute('INSERT INTO feedback VALUES (?, ?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @feedback, @rating])
        return true
    end
    return false
end

def get_total_rides(id)
    @totalRides = 0
    @journeys = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{id}' AND free_ride = 0")
    @journeys.each do |ride|
        @totalRides+=1
    end
    return @totalRides
end

def isPositiveNumber? string
  begin
      Float(string)
      int = string.to_i
      if int >= 0
          return true
      else
          return false
      end
  rescue
      return false
  end
end

def get_entry(id, table)
    return $db.execute("SELECT * FROM #{table} WHERE id = #{id}")[0]
end

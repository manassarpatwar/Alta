def gather_taxis(city)
     @availableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS '#{city}' AND available IS "1"} #Gather all taxis
     @unavailableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS '#{city}' AND available IS "0"} #Gather all taxis
end

def add_feedback(j_id, u_id, fdbk, rat)
  	#get feedback table from the database
    @feedbackInfo = $db.execute("SELECT * FROM feedback")

    @submitted = true
    #sanitize values
    if j_id.nil? then
        @journey_id = j_id
        @journey_id_ok = true
    else
        @journey_id = j_id.to_i
        @journey_id_ok = isPositiveNumber? (@journey_id)
    end
    @user_id = u_id
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    @feedback = fdbk
    @rating = rat

    # perform validation
    @feedback_ok = !@feedback.nil? && @feedback != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""
    @rating_ok = @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'


    @all_ok = @journey_id_ok && @feedback_ok && @user_id_ok && @rating_ok

    @id = @feedbackInfo[@feedbackInfo.length-1][0].to_i + 1

    # add data to the database
    if @all_ok
        # do the insert
        if !@journey_id.nil?
            $db.execute('INSERT INTO feedback VALUES (?, ?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @feedback, @rating])
        else
            $db.execute('INSERT INTO feedback VALUES (?, null, ?, ?, ?, ?)', [@id, @user_id, @date_time, @feedback, @rating])
        end
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

# Retrieves data by the specified table, column and given date from database
def get_data(table, column, date)
    data = Hash.new()
    date.each do |time|
      count = $db.execute("SELECT COUNT(*) FROM #{table} WHERE #{column} < '#{time}' OR #{column} LIKE '#{time}%'")
      data[time] = count.to_s.slice(2..-3).to_i
    end

    return data
end

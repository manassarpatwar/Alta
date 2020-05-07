def gather_taxis(city)
     @availableTaxis = $db.exec("SELECT * FROM taxis WHERE city = '#{city}' AND available = 1").map{|x| x.values} #Gather all taxis
     @unavailableTaxis = $db.exec("SELECT * FROM taxis WHERE city = '#{city}' AND available = 0").map{|x| x.values} #Gather all taxis
     @returnTaxis = @availableTaxis, @unavailableTaxis
     return @returnTaxis
end

def add_feedback(j_id, u_id, fdbk, rat)
    @submitted = true
    #sanitize values
    if j_id.nil? then
        @journey_id = j_id
    else
        @journey_id = j_id.to_i
    end
    @user_id = u_id
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    @feedback = fdbk
    @rating = rat
    # perform validation
    @journey_id_ok = @journey_id.nil? || (isPositiveNumber? (@journey_id))
    @feedback_ok = !@feedback.nil? && @feedback != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""
    @rating_ok = @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'


    @all_ok = @journey_id_ok && @feedback_ok && @user_id_ok && @rating_ok

    # add data to the database
    if @all_ok
        # do the insert
        begin
            if @journey_id.nil? then
                $db.exec("INSERT INTO feedback VALUES (DEFAULT, null, #{@user_id}, '#{@date_time}', '#{@feedback}', #{@rating})")
            else
                $db.exec("INSERT INTO feedback VALUES (DEFAULT, #{@journey_id}, #{@user_id}, '#{@date_time}', '#{@feedback}', #{@rating})")
            end
        rescue PG::Error => e
            return false
        end
        return true
    end
    return false
end

def get_total_rides(id)
    @totalRides = 0
    @journeys = $db.exec("SELECT * FROM journeys WHERE user_id = #{id} AND free_ride = 0 AND cancelled = 0").map{|x| x.values}
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
    # validation
    begin
        return $db.exec("SELECT * FROM #{table} WHERE id = #{id}")[0].values
    rescue PG::Error => e
        return nil
    end
end

# Retrieves data by the specified table, column and given date from database
def get_data(table, column, date)
    data = Hash.new()

    # validation
    if (table == "users" && column != "signup_date") || (table != "users" && column != "date_time") then
        date.each do |time|
          data[time] = 0
        end
        return data
    end

    date.each do |time|
      count = $db.exec("SELECT COUNT(*) FROM #{table} WHERE #{column} < '#{time}' OR #{column} LIKE '#{time}%'").map{|x| x.values}
      data[time] = count.to_s.slice(2..-3).to_i
    end

    return data
end

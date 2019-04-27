DB = Sequel.sqlite



DB.create_table :userjy do
    Integer :id
    Integer :date
    String :start_location
    String :end_location
    Integer :free
    Integer :cancelled
    Integer :rating
end

@results.each do |record|
    DB[:user_joruney].insert(record[0], record[1], record[2], record[3], record[4], record[5], record[6])
end
 puts DB[:user.jy].all

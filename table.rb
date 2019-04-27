require 'sequel'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   



# DB = Sequel.sqlite
# DB2 = Sequel.connect('sqlite://./taxi_database.sqlite')

# DB2.create_table :test do
#     Integer :id, :journeys
#     Integer :date
#     Integer :start_location
#     Integer :end_location
#     unique [:id, :id]
#     # unique [:date, :date_time]
#     # unique [:start_location, :start_location]
#     # unique [:end_location, :end_location]
# end

# DB2[:test].each do |row|
#     p row
#   end

# DB.create_table :people do
#   primary_key :id
#   String :name
#   Integer :date_time
# end

# DB.create_table :items do
#   foreign_key :person_id, :people
#   String  :name
#   Integer :quantity, default: 1
#   unique  [:person_id, :name]
# end

# stacey_id = DB[:people].insert(name: "Stacey", date_time: "1")
# avdi_id   = DB[:people].insert(name: "Avdi", date_time: "1")

# puts DB[:people].count #2
# puts DB[:people].all
# # => [{:id=>1, :name=>"Stacey"}, {:id=>2, :name=>"Avdi"}]]

# DB[:items].insert(avdi_id, "Pie", 2)
# DB[:items].insert(avdi_id, "Mineral Water", 1)
# DB[:items].insert(stacey_id, "Heads of Kale", 3)
# DB[:items].insert(stacey_id, "Mineral Water", 2)

# DB[:items].each do |row|
#     p row
#   end




get'/userOrders' do
    @db = SQLite3::Database.new './taxi_database.sqlite'

#         query = %{SELECT * FROM journeys WHERE id LIKE '%#{h params[:search]}%' }
        query = %{SELECT id, date_time, start_location, end_location, free_ride, cancelled, rating
                    FROM journeys
                    WHERE id LIKE '%#{params[:search]}%'}
        @results = @db.execute query
    erb :user_orders
end



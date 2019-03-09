require 'sinatra'
require 'twitter'

set :bind, '0.0.0.0'

config = {
 :consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
 :consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX ',
 :access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
 :access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
 }
        
@client = Twitter::REST::Client.new(config)

@client.update('This is an employee sending an automated tweet using Ruby')



get '/' do
    '<a href="employee">Start the job</a>'
end
    
 @employee_button == false

get '/' do
    erb :employee
    
    title = "Customer Booking List"
       unless params[:phone_no].nil?
       customer_no = params[:phone_no]
   #still need to get input from the users
       list = @client.phone_no(custome_no)
        @number = list.take(10)
       end
#Verify that the employee can contact the customer for any issues (still not complete, need customer_info)

       @employee_button = '<button type="button">Cancel</button>'
        #Verify that the employee has the option to cancel any journey  
        
     if @employee_button == true
        @phone_state = "Cancelled"
     else
        @phone_state = "Waiting"
   
        end

end
 



get '/customer' do
    @customer_button = '<a href="/">Cancel the journey</a>'
    erb :customer
    
    @drive_status == "Available"
   
    #Verify that the system marks taxis unavailable after allocation
        60.downto(0) do |i|
  if i>=0
      puts "00:#{i}"
  else
      get '/unvailable' do
          
          @drive_status == "Unavailable"
         
          #make the taxi assigned available again (still not tested)
          @customer_button = '<a href="customer">Click here to try again.</button>'
          #the button verify that the system adds the relevant information into the journey database when a taxi becomes available again (not yet tested)
    erb :unvailable                
     end
      
   end
 end
end
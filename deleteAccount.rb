class deleteMyAccount
    
    
   def delete 
       @found = false
       
       @usersTable = $db.execute %{SELECT * FROM users} #Gather all user data
        
        @usersTable.each do |record| #Go through each user record
            if env['omniauth.auth']['uid'] == record[0] #If uid = id then:
                @found = true #Boolean found is true (record is already there)
            end
        end
       
       if @found
           $db.execute("DELETE FROM users WHERE id LIKE "env['omniauth.auth']['uid']" )
           $db.execute("DELETE FROM journeys WHERE user_id LIKE "env['omniauth.auth']['uid']" )
           $db.execute("DELETE FROM complaints WHERE user_id LIKE "env['omniauth.auth']['uid']" )
       end
    end   
    
    get '/' do
        erb :home
    end

    post '/runMethod' do
        delete
        redirect '/'
    end
       
       
       
   end
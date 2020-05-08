require 'pg'
require 'csv'

csv_text_feedback = File.read("public/csv/feedback.csv")
csvFeedback = CSV.parse(csv_text_feedback, :headers => true)

csv_text_journeys = File.read("public/csv/journeys.csv")
csvJourneys = CSV.parse(csv_text_journeys, :headers => true)

csv_text_taxis = File.read("public/csv/taxis.csv")
csvTaxis = CSV.parse(csv_text_taxis, :headers => true)

csv_text_users = File.read("public/csv/users.csv")
csvUsers = CSV.parse(csv_text_users, :headers => true)

inputs = ARGV
conn = PG.connect(dbname: 'postgres')
if inputs[0] == "testdb"
  begin
    DB = PG.connect(dbname: 'taxitestdb')
  rescue PG::Error => e
    conn.exec("CREATE DATABASE taxitestdb")
    DB = PG.connect(dbname: 'taxitestdb')
  end
elsif inputs[0] == 'heroku'
  DB = PG.connect(ENV['dbconnection'])
else
  begin
    DB = PG.connect(dbname: 'altataxisdb')
  rescue PG::Error => e
    conn.exec("CREATE DATABASE altataxisdb")
    DB = PG.connect(dbname: 'altataxisdb')
  end
end

# Create a table
DB.exec("
  DROP TABLE IF EXISTS feedback;
")
DB.exec("
  DROP TABLE IF EXISTS journeys;
")
DB.exec("
  DROP TABLE IF EXISTS taxis;
")
DB.exec("
  DROP TABLE IF EXISTS users;
")

DB.exec("
  CREATE TABLE users (
	id bigint UNIQUE,
	name	TEXT NOT NULL,
	signup_date	TEXT NOT NULL,
	user_type	INT NOT NULL,
  free_rides	INT NOT NULL,
  PRIMARY KEY(id)
  );
")

DB.exec("
  CREATE TABLE feedback (
  id	SERIAL PRIMARY KEY UNIQUE,
	journey_id INT,
	user_id	bigint NOT NULL,
	date_time	TEXT NOT NULL,
	feedback	TEXT NOT NULL,
    rating INT,
  FOREIGN KEY(user_id) REFERENCES users(id)
  );
")

DB.exec("
  CREATE TABLE taxis (
	id	SERIAL PRIMARY KEY UNIQUE,
	reg_num	TEXT NOT NULL UNIQUE,
	contact_num	TEXT NOT NULL UNIQUE,
	taxi_type	TEXT NOT NULL, 
    city TEXT, 
    available INT);
")

DB.exec("
  CREATE TABLE journeys (
      id	SERIAL PRIMARY KEY UNIQUE,
      taxi_id	INT NOT NULL,
      user_id	bigint,
      twitter_handle	TEXT NOT NULL,
      date_time	TEXT NOT NULL,
      start_location	TEXT NOT NULL,
      end_location	TEXT NOT NULL,
      free_ride	INT NOT NULL,
      cancelled	INT NOT NULL,
      rating	INT,
      conversation_link	TEXT NOT NULL,
      FOREIGN KEY(user_id) REFERENCES users(id),
      FOREIGN KEY(taxi_id) REFERENCES taxis(id)
  );
")


csvUsers.each do |row|
  begin
    DB.prepare('insertUsers', 'insert into users values ($1, $2, $3, $4, $5)')
  rescue PG::Error => e
  end
  DB.exec_prepared('insertUsers', row.fields)
end

csvFeedback.each do |row|
  begin
    DB.prepare('insertFeedbacks', 'insert into feedback values (DEFAULT, $1, $2, $3, $4, $5)')
  rescue PG::Error => e
  end
  DB.exec_prepared('insertFeedbacks', row.fields.drop(1))
end

csvTaxis.each do |row|
  begin
    DB.prepare('insertTaxis', 'insert into taxis values (DEFAULT, $1, $2, $3, $4, $5)')
  rescue PG::Error => e
  end
  DB.exec_prepared('insertTaxis', row.fields.drop(1))
end

csvJourneys.each do |row|
  begin
    DB.prepare('insertJourneys', 'insert into journeys values (DEFAULT, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10)')
  rescue PG::Error => e
  end
  DB.exec_prepared('insertJourneys', row.fields.drop(1))
end

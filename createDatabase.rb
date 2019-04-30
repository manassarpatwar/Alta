require 'sqlite3'
require 'csv'
csv_text_feedback = File.read("public/csv/feedback.csv")
csvFeedback = CSV.parse(csv_text_feedback, :headers => true)

csv_text_journeys = File.read("public/csv/journeys.csv")
csvJourneys = CSV.parse(csv_text_journeys, :headers => true)

csv_text_taxis = File.read("public/csv/taxis.csv")
csvTaxis = CSV.parse(csv_text_taxis, :headers => true)

csv_text_users = File.read("public/csv/users.csv")
csvUsers = CSV.parse(csv_text_users, :headers => true)

DB = SQLite3::Database.new 'taxi_db.sqlite'
# Create a table
DB.execute <<-SQL
  DROP TABLE IF EXISTS "complaints";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "feedback";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "journeys";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "taxis";
SQL
DB.execute <<-SQL
  DROP TABLE IF EXISTS "users";
SQL
DB.execute <<-SQL
SQL

DB.execute <<-SQL
  CREATE TABLE "feedback" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"journey_id"	INTEGER,
	"user_id"	INTEGER NOT NULL,
	"date_time"	TEXT NOT NULL,
	"feedback"	TEXT NOT NULL,
    "rating" INTEGER,
	FOREIGN KEY("user_id") REFERENCES "users"("id")
  );
SQL

DB.execute <<-SQL
  CREATE TABLE "journeys" (
      "id"	INTEGER NOT NULL UNIQUE,
      "taxi_id"	INTEGER NOT NULL,
      "user_id"	INTEGER NOT NULL,
      "twitter_handle"	TEXT NOT NULL,
      "date_time"	TEXT NOT NULL,
      "start_location"	TEXT NOT NULL,
      "end_location"	TEXT NOT NULL,
      "free_ride"	INTEGER NOT NULL,
      "cancelled"	INTEGER NOT NULL,
      "rating"	INTEGER,
      "conversation_link"	TEXT NOT NULL,
      FOREIGN KEY("user_id") REFERENCES "users"("id"),
      PRIMARY KEY("id"),
      FOREIGN KEY("taxi_id") REFERENCES "taxis"("id")
  );
SQL
DB.execute <<-SQL
  CREATE TABLE "taxis" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"reg_num"	INTEGER NOT NULL UNIQUE,
	"contact_num"	INTEGER NOT NULL UNIQUE,
	"taxi_type"	TEXT NOT NULL
, city STRING, available INTEGER);
SQL
DB.execute <<-SQL
  CREATE TABLE "users" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"signup_date"	TEXT NOT NULL,
	"user_type"	INTEGER NOT NULL,
	"free_rides"	INTEGER NOT NULL, total_rides INTEGER,
	PRIMARY KEY("id")
  );
SQL

csvFeedback.each do |row|
  DB.execute "insert into feedback values ( ?, ?, ?, ?, ?, ? )", row.fields 
end

csvJourneys.each do |row|
  DB.execute "insert into journeys values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )", row.fields
end

csvTaxis.each do |row|
  DB.execute "insert into taxis values ( ?, ?, ?, ?, ?, ? )", row.fields 
end

csvUsers.each do |row|
  DB.execute "insert into users values ( ?, ?, ?, ?, ?, ? )", row.fields 
end
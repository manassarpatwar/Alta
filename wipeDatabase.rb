require 'sqlite3'
DB = SQLite3::Database.new 'taxi_db.sqlite'

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
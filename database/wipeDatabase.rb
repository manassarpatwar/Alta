# Create a table
require 'pg'

DB = PG.connect(dbname: 'altataxisdb')

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
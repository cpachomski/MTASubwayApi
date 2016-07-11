require 'csv'
require 'mysql'
require_relative 'data_formatter'
require_relative 'data/subway_lines'
require_relative 'db_con'




begin 
	con = DBCON.create

	puts "Now connected to server #{con.get_server_info}"

	con.query("CREATE TABLE IF NOT EXISTS \
		subway_entrances(Id INT PRIMARY KEY AUTO_INCREMENT, 
						 Name VARCHAR(255),
						 Lat FLOAT,
						 Lng FLOAT);")

	con.query("CREATE TABLE IF NOT EXISTS \
		subway_lines (Id INT PRIMARY KEY AUTO_INCREMENT, 
						 Name VARCHAR(255));")

	con.query("CREATE TABLE IF NOT EXISTS \
		subway_entrances_lines (Id INT PRIMARY KEY AUTO_INCREMENT, 
						 		LineId INT,
						 		EntranceId VARCHAR(255));")


	data_dir =  __dir__ + '/data/subway_entrances.csv'


	#INSERT subway line data
	SubwayLines.get_lines.each do |line|
		con.query("INSERT INTO subway_lines (Name)
				   VALUES ( '#{line}'  )")
	end


	#INSERT subway entrance
	CSV.foreach(data_dir) do |row|

		con.query("INSERT INTO subway_entrances (Name, Lat, Lng)
				   VALUES( '" + DataFormatter.get_name(row) + "', " + DataFormatter.get_lat(row).to_s + ", " + DataFormatter.get_lng(row).to_s + ");" )

		#INSERT subway entrance id and each line id for that stop into many-many associate table
		entrance_id = con.query("SELECT LAST_INSERT_ID();").fetch_row
		p DataFormatter.get_lines(row)
		DataFormatter.get_lines(row).each do |line|
			line_id = con.query("SELECT Id FROM subway_lines WHERE Name='" + line +"';").fetch_row
			unless line_id == nil
				con.query("INSERT INTO subway_entrances_lines (LineId, EntranceId) VALUES (" + line_id[0].to_s + ", " + entrance_id[0].to_s + "); ")
			end
		end


	end

	#remove first row of csv data from table
	con.query("DELETE FROM subway_entrances WHERE Lat=0")


#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
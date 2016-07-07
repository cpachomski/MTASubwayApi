require 'csv'
require 'mysql'
require_relative 'data_formatter'
require_relative 'data/subway_lines'




begin 
	con = Mysql.new ENV['DB_HOST'], ENV['DB_USER'], ENV['DB_PASSWORD'], ENV['DB_NAME']
	puts 'yo'
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


	# #INSERT subway line data
	# SubwayLines.get_lines.each do |line|
	# 	con.query("INSERT INTO subway_lines (Name)
	# 			   VALUES ( '#{line}'  )")
	# end


	# #INSERT subway entrance and line/entrance join data
	# CSV.foreach(data_dir) do |row|

	# 	con.query("INSERT INTO subway_entrances (Name, Lat, Lng)
	# 			   VALUES( '" + DataFormatter.get_name(row) + "', " + DataFormatter.get_lat(row).to_s + ", " + DataFormatter.get_lng(row).to_s + ");" )

	# 	DataFormatter.get_lines(row).each do |line|
	# 		entrance_id = con.query("SELECT LAST_INSERT_ID();").fetch_row
	# 		line_id = con.query("SELECT Id FROM subway_lines WHERE Name='" + line +"';").fetch_row
	# 		puts line_id.class
	# 		puts entrance_id.class
	# 		p line_id
	# 		p entrance_id

	# 		con.query("INSERT INTO subway_entrances_lines (LineId, EntranceId),
	# 				   VALUES (" + line_id.to_s + ", " + entrance_id.to_s + "); ")
	# 	end


	# end
		#remove first row of csv data from table
		con.query("DELETE FROM subway_entrances WHERE Lat=0")





#Error reporting
rescue Mysql::Error => e
	# puts e.errno
	# puts e.error


#Ensure connection closes
ensure
	con.close if con
end
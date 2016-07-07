require 'csv'
require 'mysql'
require_relative 'data_formatter'
require_relative 'data/subway_lines'

require_relative 'mysql_config'
CONFIG2 = MysqlConfig.new


begin 
	con = Mysql.new CONFIG2.host, CONFIG2.username, CONFIG2.password, 'mta_subway'
	puts "Now connected to server #{con.get_server_info}"

	con.query("CREATE TABLE IF NOT EXISTS \
		subway_entrances(Id INT PRIMARY KEY AUTO_INCREMENT, 
						 Name VARCHAR(255),
						 Lat FLOAT,
						 Lng FLOAT);")

	con.query("CREATE TABLE IF NOT EXISTS \
		subway_lines (Id INT PRIMARY KEY AUTO_INCREMENT, 
						 Name VARCHAR(255));")




	data_dir =  __dir__ + '/data/subway_entrances.csv'

	SubwayLines.get_lines.each do |line|
		con.query("INSERT INTO subway_lines (Name)
				   VALUES ( '#{line}'  )")
	end


		#push name data into database
	CSV.foreach(data_dir) do |row|
		puts DataFormatter.get_name(row)
		con.query("INSERT INTO subway_entrances (Name, Lat, Lng)
				   VALUES( '" + DataFormatter.get_name(row) + "', " + DataFormatter.get_lat(row).to_s + ", " + DataFormatter.get_lng(row).to_s + ");" )
	end
		con.query("DELETE FROM subway_entrances WHERE Lat=0")




#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
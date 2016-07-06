require 'csv'
require 'mysql'
require_relative 'data_formatter'
require_relative 'data/subway_lines'

require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'writers'
	puts "Now connected to server #{con.get_server_info}"
	# con.query("CREATE TABLE IF NOT EXISTS \
	# 	subway_entrances(Id INT PRIMARY KEY AUTO_INCREMENT, 
	# 					 Name VARCHAR(255),
	# 					 Lat FLOAT,
	# 					 Lng FLOAT,
	# 					 Lines Array)")


	data_dir =  __dir__ + '/data/subway_entrances.csv'

	# SubwayLines.get_lines.each do |line|
	# 	p line
	# end
	# p SubwayLines.get_lines
	# CSV.foreach(data_dir) do |row|
	# 	con.query("INSERT INTO subway_entrances (Name, Lat, Lng, Lines)
	# 			   VALUES (#{DataFormatter.get_name row},
	# 			   		   #{DataFormatter.get_lat row},
	# 			   		   #{DataFormatter.get_lng row},
	# 			   		   #{DataFormatter.get_lines row}); ")
	# end



#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
require 'csv'
require_relative 'data_formatter'
require 'mysql'
require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'writers'
	puts "Now connected to server #{con.get_server_info}"
	# con.query("CREATE TABLE IF NOT EXISTS \
	# 	subway_locations(Id INT PRIMARY KEY AUTO_INCREMENT, 
	# 					 Name VARCHAR(255),
	# 					 Lat FLOAT,
	# 					 Lng FLOAT,
	# 					 Line Arrray)")


	CSV.foreach('data/subway_entrances.csv') do |row|
		p DataFormatter.get_name row
		p DataFormatter.get_lat row
		p DataFormatter.get_lng row
		p DataFormatter.get_lines row
	end



#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
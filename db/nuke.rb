require 'mysql'
require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'mta_subway'
	puts "NUKING....."
	con.query('DELETE FROM subway_lines')
	puts "#{con.affected_rows} ROWS NUKED!"
	con.query('DELETE FROM subway_entrances')
	puts "#{con.affected_rows} ROWS NUKES!"
	
#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
require 'mysql'
require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'mta_subway'
	puts "NUKING....."
	con.query('DROP TABLE subway_lines')
	con.query('DROP TABLE subway_entrances')

	puts('All is lost...')

#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
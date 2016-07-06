require 'mysql'
require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'writers'
	puts "NUKING....."
	con.query('DELETE FROM Writers')
	puts "#{con.affected_rows} ROWS NUKED!"

#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
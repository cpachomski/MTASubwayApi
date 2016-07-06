require 'mysql'
require_relative 'mysql_config'
CONFIG = MysqlConfig.new


begin 
	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'writers'
	con.set_server_option Mysql::OPTION_MULTI_STATEMENTS_ON

	puts "Now connected to server #{con.get_server_info}"

	#Query starts here
	res = con.query "SELECT * FROM writers "

	puts res.num_rows > 1 ? "There are #{res.num_rows} rows in this table" : "There is #{res.num_rows} row in this table" 

	res.each do |row|
		puts row.join(":\s")
	end



#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
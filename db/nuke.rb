require 'mysql'
require_relative 'db_con'	



begin 
	con = DBCON.create

	puts "NUKING....."

	con.query('DROP TABLE subway_lines')
	con.query('DROP TABLE subway_entrances')
	con.query('DROP TABLE subway_entrances_lines')

	puts('All is lost...')

#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
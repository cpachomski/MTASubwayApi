require 'mysql'
require_relative 'db_con'



begin 
	# con = Mysql.new ENV['DB_HOST'], ENV['DB_USER'], ENV['DB_PASSWORD'], ENV['DB_NAME']
	con = DBCON.create

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
require 'mysql'



begin 
	p ENV["DB_HOST"]
	con = Mysql.new ENV['DATABASE_URL'], ENV['DB_USER'], ENV['DB_PASSWORD'], ENV['CLEARDB_DATABASE_URL']
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
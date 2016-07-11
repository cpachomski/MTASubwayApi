require 'mysql'
require_relative 'db_con'



begin 
	con = DBCON.create

	puts "Now connected to server #{con.get_server_info}"

	#Query starts here
	lines_res = con.query "SELECT * from subway_lines; "
	stops_res = con.query "SELECT * from subway_stations;"


	puts lines_res.num_rows != 1 ? "There are #{lines_res.num_rows} rows in the subway_lines table" : "There is #{lines_res.num_rows} row in the subway_lines table" 

	lines_res.each do |row|
		puts row.join(":\s")
	end

	puts stops_res.num_rows != 1 ? "There are #{stops_res.num_rows} rows in the subway_stations table" : "There is #{stops_res.num_rows} row in the subway_stations table" 



#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
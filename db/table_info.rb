require 'mysql'



begin 
	con = Mysql.new ENV['db_host'], ENV['db_user'], ENV['db_password'], 'mta_subway'
	con.set_server_option Mysql::OPTION_MULTI_STATEMENTS_ON

	puts "Now connected to server #{con.get_server_info}"

	#Query starts here
	lines_res = con.query "SELECT * from subway_lines; "
	entrances_res = con.query "SELECT * from subway_entrances;"


	puts lines_res.num_rows != 1 ? "There are #{lines_res.num_rows} rows in the subway_lines table" : "There is #{lines_res.num_rows} row in the subway_lines table" 

	lines_res.each do |row|
		puts row.join(":\s")
	end

	puts entrances_res.num_rows != 1 ? "There are #{entrances_res.num_rows} rows in the subway_entrances table" : "There is #{entrances_res.num_rows} row in the subway_entrances table" 



#Error reporting
rescue Mysql::Error => e
	puts e.errno
	puts e.error


#Ensure connection closes
ensure
	con.close if con
end
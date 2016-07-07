require 'mysql'
require 'json'
require_relative '../db/mysql_config'
# CONFIG = MysqlConfig.new


module Get

	def self.all
		# [{ "name" => 'William St & Fulton St At Se Corner', "Lat" => -73.9831, "Lng" => 40.6771},
		#  { "name" => 'Flatbush Ave & Empire Blvd At Sw Corner', "Lat" => -73.9622, "Lng" => 40.6627 }]
		# all = Array.new
		# begin
		# 	con = Mysql.new CONFIG.host, CONFIG.username, CONFIG.password, 'mta_subway'

		# 	res = con.query("SELECT * FROM subway_entrances")

		# 	row_count = res.num_rows

		# 	row_count.times do
		# 		all.push(res.fetch_hash)
		# 	end
			
		# end	

		puts test = {"Id"=>"2","Name"=>"Smith St & Bergen St At Ne Corner (To Manhattan And Queens Only)","Lat"=>"-73.9903","Lng"=>"40.6867"}
		test
	end
end
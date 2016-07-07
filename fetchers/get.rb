# require 'mysql'
# require 'json'
# require_relative '../db/mysql_config'



# module Get

# 	def self.all
# 		# [{ "name" => 'William St & Fulton St At Se Corner', "Lat" => -73.9831, "Lng" => 40.6771},
# 		#  { "name" => 'Flatbush Ave & Empire Blvd At Sw Corner', "Lat" => -73.9622, "Lng" => 40.6627 }]
# 		all = Array.new
# 		begin
# 			con = Mysql.new MysqlConfig.host, MysqlConfig.username, MysqlConfig.password, 'mta_subway'

# 			res = con.query("SELECT * FROM subway_entrances")

# 			row_count = res.num_rows

# 			row_count.times do
# 				all.push(res.fetch_hash)
# 			end
			
# 		end	

# 		all.to_json
# 	end
# end
require 'mysql'
require 'json'



module Get

	def self.all

		all = Array.new
		begin
			con = Mysql.new ENV['DB_HOST'], ENV['DB_USER'], ENV['DB_PASSWORD'], ENV['DB_NAME']
			res = con.query("SELECT * FROM subway_entrances")

			row_count = res.num_rows

			row_count.times do
				all.push(res.fetch_hash)
			end
			
		end	

		return all
	end
end
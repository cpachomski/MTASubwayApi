require 'mysql'
require 'json'
require_relative '../db/db_con'



module Entrances

	def self.get_all
		all = Array.new

		begin
			con = DBCON.create
			res = con.query("SELECT * FROM subway_entrances")
			row_count = res.num_rows

			row_count.times do
				all.push(res.fetch_hash)
			end
		end	

		return all
	end


end
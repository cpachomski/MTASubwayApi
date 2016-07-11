require 'mysql'
require 'json'
require_relative '../db/db_con'

module Lines

	def self.get_all
		payload = Array.new
		begin
			con = DBCON.create
			res = con.query("SELECT * FROM subway_lines")
			row_count = res.num_rows

			row_count.times do
				payload.push(res.fetch_hash)
			end
		end

		return payload
	end

	def self.get_by_id id

		begin
			con = DBCON.create
			res = con.query("SELECT * FROM subway_lines
							 WHERE Id=#{id};")
			p '#' * 50
			return res.fetch_hash

		end
	end

	def self.get_stations_by_id id
		payload = Array.new

		begin
			con = DBCON.create
			res = con.query("SELECT Name
							 FROM subway_stations as s
							 INNER JOIN subway_stations_lines as sl
							 	ON s.Id = sl.StationId
							 WHERE sl.LineId=#{id};")
			row_count = res.num_rows

			row_count.times do
				payload.push(res.fetch_hash)
			end

			return payload
		end
	end
end
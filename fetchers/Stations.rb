require 'mysql'
require 'json'
require_relative '../db/db_con'



module Stations

	def self.get_all
		payload = Array.new

		begin
			con = DBCON.create
			res = con.query("SELECT * FROM subway_stations")
			row_count = res.num_rows

			row_count.times do
				payload.push(res.fetch_hash)
			end
		end	

		return payload
	end

	def self.get_all_within_radius(opts)
		payload = Array.new
		#check for radius or use default
		#NOTE: 0.015 deg ~= 1mi and 0.01 ~= 1km
		radius = opts[:radius] || 0.005
		lat_max = opts[:lat].to_f + radius.to_f 
		lat_min = opts[:lat].to_f - radius.to_f
		lng_max = opts[:lng].to_f + radius.to_f
		lng_min = opts[:lng].to_f - radius.to_f
		query = "SELECT * FROM subway_stations WHERE "

		#build query bounds for lat lng if they exist   
		unless opts[:lat] == nil
			lat_within_radius = "(Lat > '#{lat_min}' AND Lat < '#{lat_max}')"
		end

		unless opts[:lng] == nil
			lng_within_radius = "(Lng < '#{lng_max}' AND Lng > '#{lng_min}')"
		end

		#finish building query from opts
		case 
		when opts[:lat] != nil && opts[:lng] != nil
			query = query + lat_within_radius + ' AND ' + lng_within_radius
		when opts[:lat] != nil
			query = query + lat_within_radius
		when opts[:lng] != nil
			query = query + lng_within_radius
		end

		begin
			con = DBCON.create
			res = con.query(query)
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
			res = con.query("SELECT * FROM subway_stations
							 WHERE Id=#{id}")
			
			return res.fetch_hash
		end
	end

	def self.get_lines_by_id id

		payload = Array.new
		begin 
			puts id.to_s +  " ID SEARCHED"
			con = DBCON.create
			res = con.query("SELECT Name
							 FROM subway_lines as l
							 INNER JOIN subway_stations_lines as sl
							 	ON l.Id = sl.LineId
							 WHERE sl.StationId=#{id};")

			row_count = res.num_rows

			row_count.times do
				payload.push(res.fetch_hash)
			end

			return payload
		end
	end
end
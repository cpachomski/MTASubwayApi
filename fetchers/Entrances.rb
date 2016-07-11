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
			p "ROW COUNT #{row_count}"

			row_count.times do
				all.push(res.fetch_hash)
			end
		end	

		return all
	end

	def self.get_all_within_radius(opts)
		all = Array.new
		#check for radius
		radius = opts[:radius] || 0.005
		puts opts[:lat]
		puts opts[:lng]
		puts radius
		lat_max = opts[:lat].to_f + radius.to_f 
		lat_min = opts[:lat].to_f - radius.to_f
		lng_max = opts[:lng].to_f + radius.to_f
		lng_min = opts[:lng].to_f - radius.to_f

		query = "SELECT * FROM subway_entrances WHERE "


		#build query bounds for lat lng		   
		unless opts[:lat] == nil
			lat_within_radius = "(Lat > '#{lat_min}' AND Lat < '#{lat_max}')"
		end

		unless opts[:lng] == nil
			lng_within_radius = "(Lng < '#{lat_max}' AND Lng > '#{lat_min}')"
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
			p "ROW COUNT #{row_count}"

			row_count.times do
				all.push(res.fetch_hash)
			end
		end

		return all
	end


end
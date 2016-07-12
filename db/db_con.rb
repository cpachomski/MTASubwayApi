require 'mysql'

module DBCON

	def self.create
		con = Mysql.new ENV['DB_HOST'], ENV['DB_USER'], ENV['DB_PASSWORD'], ENV['DB_NAME']
	end
end
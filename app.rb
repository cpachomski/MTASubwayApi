require 'sinatra'

class MtaSubwayApi < Sinatra::Base
	get '/' do
		"Hello Squirrel"
	end
end
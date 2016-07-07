require 'sinatra'
require_relative 'fetchers/get'

class MtaSubwayApi < Sinatra::Base
	get '/' do
		"Hello Squirrel"
	end

	get '/entrances' do
		 Get.all
	end

end
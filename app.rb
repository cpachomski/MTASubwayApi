require 'sinatra'
require_relative 'fetchers/get'


get '/' do
	"Hello Squirrel"
end

get '/entrances' do
	content_type :json
	
	 Get.all.to_json
end


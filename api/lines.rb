require_relative "../fetchers/Lines"

#LINES ROUTES
get '/lines' do
	content_type :json

	return Lines.get_all.to_json
end

get '/lines/' do
	content_type :json

	return Lines.get_all.to_json
end

get '/lines/:id' do
	content_type :json

	return Lines.get_by_id(params[:id]).to_json
end

get '/lines/:id/' do
	content_type :json

	return Lines.get_by_id(params[:id]).to_json
end


get '/lines/:id/stations' do
	content_type :json

	return Lines.get_stations_by_id(params[:id]).to_json
end


get '/lines/:id/stations/' do
	content_type :json

	return Lines.get_stations_by_id(params[:id]).to_json
end

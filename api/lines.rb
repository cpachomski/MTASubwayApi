require_relative "../fetchers/lines"

#LINES ROUTES

get '/api/mta/subway/lines' do
	content_type :json

	return Lines.get_all.to_json
end


get '/api/mta/subway/lines/:id' do
	content_type :json

	return Lines.get_by_id(params[:id]).to_json
end

get '/api/mta/subway/lines/:id/stations' do
	content_type :json

	return Lines.get_stations_by_id(params[:id]).to_json
end




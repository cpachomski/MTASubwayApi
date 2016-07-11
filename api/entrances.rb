require_relative '../fetchers/entrances'


# ENTRANCES ROUTES

get '/api/mta/subway/entrances' do
	content_type :json

	puts params
	if params['lat'] || params['lng'] 
		return Entrances.get_all_within_radius({:lat => params['lat'], :lng => params['lng'], :radius => params['radius']}).to_json
	end

	return Entrances.get_all.to_json
end


get '/api/mta/subway/entrances/:id' do
	content_type :json
	
	return Entrances.get_by_id(params[:id]).to_json
end


get '/api/mta/subway/entrances/:id/lines' do
	content_type :json

	return Entrances.get_lines_by_id(params[:id]).to_json
end

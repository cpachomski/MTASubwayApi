require_relative '../fetchers/Stations'


# ENTRANCES ROUTES

get '/stations' do
	content_type :json

	puts params
	if params['lat'] || params['lng'] 
		return Stations.get_all_within_radius({:lat => params['lat'], :lng => params['lng'], :radius => params['radius']}).to_json
	end

	return Stations.get_all.to_json
end

get '/stations/' do
	content_type :json

	puts params
	if params['lat'] || params['lng'] 
		return Stations.get_all_within_radius({:lat => params['lat'], :lng => params['lng'], :radius => params['radius']}).to_json
	end

	return Stations.get_all.to_json
end

get '/stations/:id' do
	content_type :json
	
	return Stations.get_by_id(params[:id]).to_json
end

get '/stations/:id/' do
	content_type :json
	
	return Stations.get_by_id(params[:id]).to_json
end

get '/stations/:id/lines' do
	content_type :json

	return Stations.get_lines_by_id(params[:id]).to_json
end

get '/stations/:id/lines/' do
	content_type :json

	return Stations.get_lines_by_id(params[:id]).to_json
end

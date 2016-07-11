require_relative "../fetchers/lines"

#LINES ROUTES

get '/api/mta/subway/lines' do
	content_type :json

	return Lines.get_all.to_json
end





# get '/api/mta/subwayentrances/:id' do
# 	content_type :json
# end

# get '/api/mta/subwayentrances' do

# end
require 'sinatra'

#import APIs
require_relative 'api/stations'
require_relative 'api/lines'

#docs
get '/' do
	erb :index
end

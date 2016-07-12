require_relative 'app'

configure do
    set :protection, except: [:frame_options]
end

run Sinatra::Application
get '/' do
	if logged_in?
		redirect '/main_page'
	else
		erb :index
	end
end

get '/main_page' do
	if logged_in?
		erb :main_page
	else
		redirect '/'
	end
end

get '/etsy_key' do
	etsy_key = ENV['ETSY_KEY']
	content_type :json
	etsy_key.to_json
end




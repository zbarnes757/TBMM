get '/' do
	beard1 = random_beard
	beard2 = random_beard
	if logged_in?
		redirect '/main_page'
	else
		erb :index, locals: {
			beard1: beard1,
			beard2: beard2,
		}
	end
end

get '/main_page' do
	beard1 = random_beard
	beard2 = random_beard
	if logged_in?
		erb :main_page, locals: {
			beard1: beard1,
			beard2: beard2,
		}
	else
		redirect '/'
	end
end

get '/etsy_key' do
	etsy_key = ENV['ETSY_KEY']
	content_type :json
	etsy_key.to_json
end




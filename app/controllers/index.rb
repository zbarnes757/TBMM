get '/' do
	if logged_in?
		redirect '/main_page'
	else
		erb :index
	end
end

post '/user/create' do
	user = User.new(params)
	if user.save!
		session[:user_id] = user.id
		redirect '/main_page'
	else
		flash[:errors] = user.errors.full_messages
		redirect '/'
	end
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
		redirect '/main_page'
  else
  	flash[:errors] = "Try Again!"
  	redirect '/'
  end
end

get '/main_page' do
	if logged_in?
		erb :main_page
	else
		redirect '/'
	end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

get '/etsy_key' do
	etsy_key = ENV['ETSY_KEY']
	content_type :json
	etsy_key.to_json
end

get '/user/items' do
	items = current_user.items.map { |item| item.attributes  }
	content_type :json
	items.to_json
end

post '/user/items/add' do
	item = current_user.items.create(params)
	content_type :json
	item.to_json
end

delete '/user/items/delete' do
	Item.find(params[:id]).destroy
	status 200
end




get '/' do
	erb :index
end

post '/user/create' do
	user = User.new(params)
	content_type :json
	if user.save!
		session[:user_id] = user.id
		{name: user.name}.to_json
	else
		status 400
	end
end

post '/login' do
  user = User.find_by(email: params[:email])
		content_type :json
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
		{name: user.name}.to_json
  else
  	status 401
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




get '/' do
	# if logged_in?
	# 	redirect '/'
	# else
		erb :index
	# end
end

post '/user/create' do
	user = User.new(params)
	if user.save!
		session[:user_id] = user.id
		content_type :json
		status 200
		{name: user.name}.to_json
	else
		errors = user.errors.full_messages
		content_type :json
		{errors: errors}.to_json
	end
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
		# redirect "/user/#{user.id}"
  else
    flash[:errors] = "Try again"
    redirect '/'
  end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end
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
		{name: user.name}.to_json
	else
		status 400
		# errors = user.errors.full_messages
		# content_type :json
		# erb :index
	end
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
		content_type :json
		{name: user.name}.to_json
  else
  	status 401
    # flash[:errors] = "Try again"
    # redirect '/'
  end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end
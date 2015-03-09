get '/' do
	erb :index
end

post '/user/create' do
	user = User.new(params)
	if user.save!
		session[:user_id] = user.id
		# redirect "/user/#{user.id}"
	else
		session[:errors] = user.errors.full_messages
		redirect '/'
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
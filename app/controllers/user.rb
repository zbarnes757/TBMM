post '/user/create' do
	user = User.new(params)
	if user.save
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
get '/logout' do
	session[:user_id] = nil
	redirect '/'
end
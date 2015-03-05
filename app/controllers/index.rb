get "/" do
  erb :index
end

post "/signup" do
  @user = User.new(params)
  if @user.save
    session[:user_id] = @user.id
    redirect "/#{@user.user_name}"
  else
    flash[:error] = "Username already taken"
    redirect "/"
  end
end

post "/login" do
  @user = User.find_by(user_name: params[:user_name])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/#{@user.user_name}"
  else
    flash[:error] = "User name or password incorrect"
    redirect "/"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get "/:user_name" do
  @user = User.find_by(user_name: params[:user_name])
  if session[:user_id] == @user.id
    #enables partial that allows you to create surverys
  else
    #lets person see all of that user page's  surevys and take them
  end
end

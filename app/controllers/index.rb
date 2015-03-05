get "/" do
  erb :index
end

post "/signup" do
  @user = User.new(params)
  if @user.save
    redirect "/#{@user.user_name}"
  else
    @errors = @user.errors
    redirect "/"
  end
end

get "/:user_name" do
  p "we are at your home page"
end

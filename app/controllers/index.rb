
get '/' do
  # session for late
  erb :index # do index.erb
end

get '/surveys/new' do
  # session for later
  erb :create_new_survey
end

post '/surveys' do
  # session for later
  # create survey based on params
  # redirecting user to the new survey page instead to create questions
  survey = Survey.create(title: params[:title])
  redirect "/surveys/#{survey.id}/question_new"
end

# for creating new questions
get '/surveys/:survey_id/question_new' do
  @survey = Survey.find(params[:survey_id])
  erb :create_new_question # created not sure if works
end

#display a survey and its questions
get '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :survey #need to show the survey - Create survey.erb
end

post '/questions' do
  # session for later
  # create survey based on params
  Question.create(
    content: params[:content],
    survey_id: params[:survey_id],
    )
  redirect "/surveys/#{params[:survey_id]}"
  # redirecting to the survey page but not sure how to get the corresponding survey based on the question
end

post "/signup" do
  @user = User.new(params)
  if @user.save
    session[:user_id] = @user.id
    redirect "/user/#{@user.user_name}"
  else
    flash[:error] = "Username already taken"
    redirect "/"
  end
end

post "/login" do
  @user = User.find_by(user_name: params[:user_name])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/user/#{@user.user_name}"
  else
    flash[:error] = "User name or password incorrect"
    redirect "/"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/users' do
  #shows list of all survey creators
end

get "/user/:user_name" do
  @user = User.find_by(user_name: params[:user_name])
  if session[:user_id] == @user.id
    #create survey link and edit links
    erb :profile
  else
    #take survey links
  end
end

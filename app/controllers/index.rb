get '/' do
  # session for late
  erb :index # do index.erb
end

get '/surveys/new' do
  # session for later
  erb :create_new_survey
end

post 'surveys' do
  # session for later
  # create survey based on params
  Survey.create(title: params[:title])
  redirect '/'
end

get '/surveys/:survey_id/new' do
  # sessions for later
  erb :create_new_question # created not sure if works
end

#display a survey and its questions
get '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :survey #need to show the survey - Create survey.erb
end

post 'questions' do
  # session for later
  # create survey based on params
  question = Question.create(content: params[:content])
  redirect '/surveys/??'
  # redirecting to the survey page but not sure how to get the corresponding survey based on the question
end

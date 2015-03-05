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
  erb :create_new_question
end

post 'questions' do
  # session for later
  # create survey based on params
  Question.create(content: params[:content])
end

get '/' do
  # session for late
  erb :index # do index.erb
end

get '/surveys/new' do
  # session for later
  erb :create_new_survey # do create_new_survey.erb
end

post 'surveys' do
  # session for later
  # create survey based on params
  # @survey = Survey.create(title:params[:title])
  # maybe validations?
  redirect '/'
end

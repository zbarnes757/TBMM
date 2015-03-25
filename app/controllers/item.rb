get '/user/items' do
	items = current_user.items.map { |item| item.attributes  }
	content_type :json
	items.to_json
end

post '/user/items' do
	item = current_user.items.create(params)
	status 200
end

delete '/user/items' do
	Item.find(params[:id]).destroy
	status 200
end
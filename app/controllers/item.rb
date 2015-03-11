get '/user/items' do
	items = current_user.items.map { |item| item.attributes  }
	content_type :json
	items.to_json
end

post '/user/items/add' do
	item = current_user.items.create(params)
	content_type :json
	item.to_json
end

delete '/user/items/delete' do
	Item.find(params[:id]).destroy
	status 200
end
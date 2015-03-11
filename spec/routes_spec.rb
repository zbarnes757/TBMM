require 'spec_helper'

describe "Routes" do

	before(:all) do
		user = User.create(
			name: "Person",
			email: "example@gmail.com",
			password: "123456",
		)
		user.items.create(
			title: "thing1",
			price: "4.00",
			description: "things you do with thing1",
			image_url: "notAUrl",
			product_url: "notAUrlAgain"
			)

	end


  context "basic index" do
  	context "GET '/'" do
  		it "should display signup and login forms when not logged in" do
  			get '/'
  			expect(last_response.body).to include('sign-up-form','login-form')
  		end

  		it "should redirect to the main page if logged in" do
  			get '/', {}, "rack.session" => {:user_id => 1}
  			expect(last_response).to be_redirect
  			expect(last_response.location).to include('main_page')
  		end
  	end

  	context "get '/main_page'" do
  		it "should display search buttons for the user if logged in" do
  			get '/main_page', {}, "rack.session" => {:user_id => 1}
  			expect(last_response.body).to include('safety-razors', 'shaving-brushes', 'shaving-cream', 'shaving-kits')
  		end

  		it "should redirect to the index page if not logged in" do
  			get '/main_page'
  			expect(last_response).to be_redirect
  			expect(last_response.location).to_not include('main_page')
  		end
  	end
  end


  context "user routes" do
  	context "post '/user/create'" do
  		it "should create a new user when passed the right params" do
  			post '/user/create', {name: "Person2", email: "example2@gmail.com", password: "123456"}
  			expect(User.pluck('email')).to include("example2@gmail.com")
  		end

  		it "should not create a new person with bad info" do
  			post '/user/create', {name: "Person3", email: "notAnEmail", password: "123456" }
  			expect(User.pluck('name')).to_not include("Person3")
  		end

  		it "should redirect back to home page with bad info" do
  			post '/user/create', {name: "Person3", email: "notAnEmail", password: "123456" }
  			expect(last_response.location).to eq("http://example.org/")
  		end
	  end


	  context "post '/login'" do
	  	it "should redirect you to main_page with good data" do
	  		post '/login', { email: "example@gmail.com", password: "123456" }
	  		expect(last_response.location).to include('/main_page')
	  	end

	  	it "should redirect you to index with bad data" do
	  		post '/login', { email: "notExample@gmail.com", password: "123456" }
	  		expect(last_response).to be_redirect
	  		expect(last_response.location).to eq("http://example.org/")
	  	end
	  end
  end

  context "item routes" do
  	context "get '/user/items'" do
  		it "should return the current user's items" do
  			get '/user/items', {}, "rack.session" => {:user_id => 1}
  			expect(JSON.parse(last_response.body)[0]).to have_value(1)
  			expect(JSON.parse(last_response.body)[0]).to have_value("thing1")
  			expect(JSON.parse(last_response.body)[0]).to have_value("things you do with thing1")
  			expect(JSON.parse(last_response.body)[0]).to have_value("notAUrl")
  			expect(JSON.parse(last_response.body)[0]).to have_value("notAUrlAgain")
  			expect(JSON.parse(last_response.body)[0]).to have_value("4.00")
  		end
  	end

  	context "post '/user/items/add'" do
  		it "should create a new item" do
  			thing2 = {
  				"title"=>"thing2",
  				"description"=>"things to do with thing2",
  				"price"=>"7.50",
  				"image_url"=>"noPlace",
  				"product_url"=>"notEtsy"
  			}
	  		post '/user/items/add', thing2 , "rack.session" => {:user_id => 1}
	  		expect(Item.pluck('title')).to include("thing2")
	  	end
  	end

  	context "delete '/user/items/delete'" do
  		it "should delete an item from the database" do
  			delete '/user/items/delete', {"id"=>"1"}, "rack.session" => {:user_id => 1}
  			expect(Item.pluck('title')).to_not include("thing1")
  		end
  	end
  end
  
end

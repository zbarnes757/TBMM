require 'spec_helper'

describe "Routes" do

	before(:all) do
		User.create(
			name: "Person",
			email: "example@gmail.com",
			password: "123456",
		)

	end


  context "basic index" do
  	context "GET '/'" do
  		it "should display signup and login forms when not logged in" do
  			get '/'
  			expect(last_response.body).to include('sign-up-form')
  			expect(last_response.body).to include('login-form')
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


  # context "user routes" do

  # end
end

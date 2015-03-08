require 'spec_helper'

describe User do
  let(:user) do
    User.new(
      name: "John Doe",
      email: "John@Doe.com",
      password: "password"
      )
  end
  describe "at creation" do
    it "a user must have a name, email address and password" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "a user must have a valid email" do
      user.email = "notValidEmail"
      expect(user).to_not be_valid
    end

    it "a user must have a unique email" do
      user2 = User.create(name: "Jane Doe", email: "John@Doe.com", password: "password2")
       expect(user).to_not be_valid
     end
     
  end

end
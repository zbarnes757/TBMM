require 'spec_helper'

describe Item do
	
	context "user" do
	  it {should belong_to(:user)}
	end

end

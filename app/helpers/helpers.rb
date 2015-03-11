helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def random_beard
  	beards = ["beards/beard-slogan1.jpeg", "beards/beard-slogan2.jpeg", "beards/beard-slogan3.jpeg", "beards/beard-slogan4.jpeg", "beards/beard-slogan5.jpeg", "beards/beard-slogan6.jpeg", "beards/beard-slogan7.jpeg", "beards/beard-slogan8.jpeg", "beards/beard-slogan9.jpeg", "beards/beard-slogan10.jpeg", "beards/beard-slogan11.jpeg", "beards/beard-slogan12.jpeg", "beards/beard-slogan13.jpeg", "beards/beard-slogan14.jpeg"]
  	return beards.sample
  end
end

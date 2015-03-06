class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true
  validates :password_hash, presence: true
  has_many :surveys


  include BCrypt

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end


end

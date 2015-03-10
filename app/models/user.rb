class User < ActiveRecord::Base
  include BCrypt

  has_many :items

  validates :email, uniqueness: true
  validates :password_hash, :email, :name, presence:true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

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

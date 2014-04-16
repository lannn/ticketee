class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  protected
  def password_required?
    false
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :omniauthable

  has_many :permissions

  before_save :ensure_authentication_token

  def display_name
    if twitter_id
      "#{twitter_display_name} (@#{twitter_screen_name})"
    else
      email
    end  
  end

  def to_s
    "#{display_name} (#{admin? ? "Admin" : "User"})"
  end

  def self.reset_request_count!
    update_all("request_count = 0", "request_count > 0") 
  end

  def self.find_or_create_for_twitter(response)
    data = response['extra']['raw_info']
    if user = User.find_by_twitter_id(data["id"].to_s)
      user
    else
      user = User.new(email: "twitter+#{data["id"]}@example.com", password: Devise.friendly_token[0,20])
      user.twitter_id = data["id"].to_s
      user.twitter_screen_name = data["screen_name"]
      user.twitter_display_name = data["display_name"]
      user.confirm!
      user
    end
  end
  private

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable, :omniauth_providers => [:facebook]

  validates(:first_name, presence: true)
  validates(:last_name, presence: true)
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      #debugger
      user = User.create(first_name: auth.extra.raw_info.first_name,
                         last_name: auth.extra.raw_info.last_name,
                         provider: auth.provider,
                         uid: auth.uid,
                         authentication_token: auth.credentials.token,
                         email: auth.info.email,
                         password: Devise.friendly_token[0,20]
                        )
    end
    user
  end
end

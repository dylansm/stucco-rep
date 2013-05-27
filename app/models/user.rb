class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable, :omniauth_providers => [:facebook]

  validates(:first_name, presence: true)
  validates(:last_name, presence: true)

  after_create { |user| user.send_activate_instructions }

  def send_activate_instructions(attributes={})
    generate_reset_password_token! if should_generate_reset_token?
    send_devise_notification(:activate_instructions)
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    # if user not found by oauth provider uid find by email
    # and update oauth attributes
    unless user
      user = self.update_oauth_by_email(auth)
    end

    #unless user
      #user = User.create(first_name: auth.extra.raw_info.first_name,
                         #last_name: auth.extra.raw_info.last_name,
                         #provider: auth.provider,
                         #uid: auth.uid,
                         #authentication_token: auth.credentials.token,
                         #email: auth.info.email,
                         #password: Devise.friendly_token[0,20])
    #end
    user
  end

  private

  def self.update_oauth_by_email(auth)
    user = User.where(:email => auth.info.email).first
    if user
      user.update_attributes(provider: auth.provider,
                             uid: auth.uid,
                             authentication_token: auth.credentials.token)
    end
    user
  end

  def password_required?
    new_record? ? false : super
  end
end

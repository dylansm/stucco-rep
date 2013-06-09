class User < ActiveRecord::Base
  has_one :user_application, autosave: true
  belongs_to :school
  has_many :tools
  has_many :adobe_products, :through => :tools

  accepts_nested_attributes_for :user_application, :tools

  has_many :members, :class_name => "User",
    :foreign_key => "program_admin_id"
  belongs_to :program_admin, :class_name => "User"
  belongs_to :program
  
  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :registerable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable, :omniauth_providers => [:facebook]

  validates(:first_name, presence: true)
  validates(:last_name, presence: true)

  attr_writer :skip_email_notification

  after_create do |user|
    unless @skip_email_notification
      send_activate_instructions
    end
  end

  def skip_email_notification!
    @skip_email_notification = true
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    # if user not found by oauth provider uid find by email
    # and update oauth attributes
    unless user
      user = self.update_oauth_by_email(auth)
    end

    user
  end

  def fetch_facebook_stream
    posts = FbGraph::Query.new(
      "SELECT message,comment_info,share_count,likes,created_time FROM stream WHERE strpos(message, '#adobehashtag') >= 0 AND source_id = #{uid} AND updated_time > 1350000000"
    )
    posts.access_token = authentication_token
    posts.fetch
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

  def send_activate_instructions(attributes={})
    generate_reset_password_token! if should_generate_reset_token?
    send_devise_notification(:activate_instructions)
  end

end

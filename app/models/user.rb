class User < ActiveRecord::Base
  has_one :user_application, autosave: true, dependent: :destroy
  belongs_to :school
  has_many :tools, dependent: :destroy, after_add: :add_name_to_tool
  has_many :adobe_products, through: :tools
  has_and_belongs_to_many :programs
  has_many :program_marquees, through: :programs
  has_many :posts
  has_many :comments
  has_many :responses, through: :posts, source: :comments
  has_many :likes, dependent: :destroy
  has_many :notifications
  has_many :notifiers, class_name: "User"
  #has_and_belongs_to_many :notifiers, class_name: "User", foreign_key: "notifier_id"
  accepts_nested_attributes_for :user_application, :tools

  # Include default devise modules. Others available are: :token_authenticatable, :confirmable, :registerable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable, :omniauth_providers => [:facebook]

  validates(:first_name, presence: true)
  validates(:last_name, presence: true)

  has_attached_file(:avatar,
                    styles: { sm: "40x40#", sm2x: "80x80#", med: "60x60#", med2x: "120x120#", lg: "140x140#", lg2x: "280x280#" },
                    default_url: "/assets/:attachment/missing/:style/avatar_missing.gif"
                   )
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

  attr_writer :skip_email_notification

  after_create do |user|
    unless @skip_email_notification
      send_activate_instructions
    end
  end

  before_save :remove_avatar?

  class << self

    def not_in_program(program, admin_only=false)
      if program.users.any?
        where("admin = ? AND id NOT IN (?)", admin_only, program.users.map(&:id))
      else
        where("admin = ?", admin_only)
      end
    end

  end

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url_lg(retina=false)
    retina ? avatar.url(:lg2x) : avatar.url(:lg)
  end

  def avatar_url_med(retina=false)
    retina ? avatar.url(:med2x) : avatar.url(:med)
  end

  def avatar_url_sm(retina=false)
    retina ? avatar.url(:sm2x) : avatar.url(:sm)
  end

  def program
    begin
      Program.find(current_program_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def skip_email_notification!
    @skip_email_notification = true
  end

  def active_for_authentication?
    super and is_active?
  end

  def is_active?
    self.active_for_authentication ? true : false
  end

  def inactive_message
    self.active_for_authentication ? super : :suspended
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

  def remove_avatar
    @remove_avatar ||= false
  end

  def remove_avatar=(value)
    @remove_avatar = !!value
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

  def add_name_to_tool(tool)
    tool.add_names
  end

  def remove_avatar?
    self.avatar = nil if self.remove_avatar && !self.avatar.dirty?
  end


end

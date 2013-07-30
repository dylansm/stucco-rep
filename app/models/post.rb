class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  validates(:text, presence: true)
  default_scope { order("created_at DESC") }

  has_attached_file :post_image, styles: { sm: "320x", med: "530x", :"sm@2x" => "640x", :"med@2x" => "1060x" }

  before_save :remove_attachments?

  def post_image_urls
    { med: post_image.url(:med), :"med_2x" => post_image.url(:"med@2x"), sm: post_image.url(:sm), sm_2x: post_image.url(:"sm@2x") } if post_image.file?
  end

  def video_type
    @video_type ||= derive_video_type_from_url
  end

  def video_id
    @video_id ||= derive_id_from_url
  end

  def remove_image
    @remove_image ||= false
  end

  def remove_image=(value)
    @remove_image = !!value
  end

  private

  def derive_id_from_url
    if video_type == "youtube"
      if /youtu\.be/ =~ video_url
        video_url.gsub('http://youtu.be/', '')
      else
        id = video_url[/v=.([^&])+/]
        id = id[2..-1]
      end
    elsif video_type == "vimeo"
      last_slash_index = video_url.rindex(/\/\d/) + 1
      id = video_url[last_slash_index..-1]
    end
  end

  def derive_video_type_from_url
    if /youtu.be|youtube/ =~ video_url
      "youtube"
    elsif /vimeo\.com/ =~ video_url
      "vimeo"
    end
  end

  def remove_attachments?
    self.post_image = nil if self.remove_image && !self.post_image.dirty?
  end

end

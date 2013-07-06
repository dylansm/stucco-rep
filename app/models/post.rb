class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates(:text, presence: true)
  default_scope { order("created_at DESC") }

  has_attached_file :post_image, styles: { sm: "320x", med: "530x", :"sm@2x" => "640x", :"med@2x" => "1060x" }

  def post_image_urls
    { med: post_image.url(:med), :"med_2x" => post_image.url(:"med@2x"), sm: post_image.url(:sm), sm_2x: post_image.url(:"sm@2x") } if post_image.file?
  end

  def video_type
    @video_type ||= derive_video_type_from_url
  end

  def video_id
    @video_id ||= derive_id_from_url
  end

  private

  def derive_id_from_url
    if video_type == "youtube"
      video_url.gsub('http://youtu.be/', '')
    elsif video_type == "vimeo"
      last_slash_index = video_url.rindex(/\/\d/) + 1
      id = video_url[last_slash_index..-1]
    end
  end

  def derive_video_type_from_url
    if /youtu.be/ =~ video_url
      "youtube"
    elsif /vimeo\.com/ =~ video_url
      "vimeo"
    end
  end

end

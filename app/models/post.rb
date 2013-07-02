class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates(:text, presence: true)
  default_scope { order("created_at DESC") }
  
  def as_json(options={})
    super(options.merge(
      only: [ :id, :text, :published_at ], methods: [ :image_url, :video_type, :video_id ],
      include: [ user: { only: [ :id ], methods: [ :avatar_url, :name ] }, 
                 comments: { only: [ :text ] } ]))
  end

  def image_url
  end

  def video_type
    @video_type ||= derive_video_type_from_url
  end

  def video_id
    if video_type == "youtube"
      video_url.gsub('http://youtu.be/', '')
    elsif video_type == "vimeo"
      last_slash_index = video_url.rindex(/\/\d/) + 1
      video_url[last_slash_index..-1]
    end
  end

  private

  def derive_video_type_from_url
    if /youtu.be/ =~ video_url
      "youtube"
    elsif /vimeo\.com/ =~ video_url
      "vimeo"
    end
  end

end

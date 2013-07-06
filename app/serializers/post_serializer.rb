class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :post_image_urls, :video_type, :video_id
  has_many :comments
  has_one :user, serializer: PostUserSerializer
  
  def post_image_urls
    object.post_image_urls
  end

  def video_type
    object.video_type
  end

  def video_id
    object.video_id
  end

end

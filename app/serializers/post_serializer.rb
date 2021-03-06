class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :post_image_urls, :video_type, :video_url, :video_id
  has_many :comments
  has_many :likes, each_serializer: LikeSerializer
  has_one :user, serializer: PostUserSerializer
  has_one :rating, serializer: PostRatingSerializer
  
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

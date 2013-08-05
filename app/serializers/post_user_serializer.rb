class PostUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url_med, :avatar_url_med2x
  has_one :school, serializer: PostSchoolSerializer

  def name
    object.name
  end

  def avatar_url_med
    object.avatar_url_med
  end

  def avatar_url_med2x
    object.avatar_url_med(true)
  end
end

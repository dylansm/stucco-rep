class PostUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url, :avatar_url_sm
  has_one :school, serializer: PostSchoolSerializer

  def name
    object.name
  end
end

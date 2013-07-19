class PostUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url
  has_one :school, serializer: PostSchoolSerializer

  def name
    object.name
  end
end

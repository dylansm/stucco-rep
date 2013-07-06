class PostUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url

  def name
    object.name
  end
end

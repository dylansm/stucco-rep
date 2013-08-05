class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url_lg, :avatar_url_lg2x

  def name
    object.name
  end

  def avatar_url_lg
    object.avatar_url_lg
  end

  def avatar_url_lg2x
    object.avatar_url_lg(true)
  end

end

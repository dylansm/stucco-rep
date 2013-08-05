class CommentUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url_sm, :avatar_url_sm2x
  #has_one :school, serializer: PostSchoolSerializer

  def name
    object.name
  end

  def avatar_url_sm
    object.avatar_url_sm
  end

  def avatar_url_sm2x
    object.avatar_url_sm(true)
  end
end

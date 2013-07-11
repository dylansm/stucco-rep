class LikedPostSerializer < ActiveModel::Serializer
  attributes :id
  has_many :likes, each_serializer: LikeSerializer
end

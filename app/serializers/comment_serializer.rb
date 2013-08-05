class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
  has_one :user, serializer: CommentUserSerializer
end

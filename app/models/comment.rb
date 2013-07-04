class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def as_json(options={})
    super(options.merge(
      only: [ :text, :created_at ], methods: [ :name ],
      include: [ user: { only: [ :id, :active_for_authentication, :admin, :created_at ], methods: [ :name, :avatar_url ] } ]))
  end

  def name
    user.name
  end
end

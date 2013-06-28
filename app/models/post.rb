class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def as_json(options={})
    super(options.merge(
      :only => [ :id, :text, :published_at, :image_url ], 
      :include => [ user: { only: [ :id, :name ], methods: [ :avatar_url ] }, 
                    comments: { only: [ :text ] } ],
      :methods => [ :image_url ]))
  end

  private

  def image_url
  end

end

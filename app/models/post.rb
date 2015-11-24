class Post < ActiveRecord::Base

  validates(:title, {presence:   true,
                    uniqueness: {message: "was used already"},
                    length:     {minimum: 3}})

  validates :body, presence:   true,
                   uniqueness: {scope: :title}

  has_many :comments, dependent: :destroy

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  mount_uploader :image, ImageUploader


  def liked_by?(user)
    like_for(user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def voted_on_by?(user)
    vote_for(user).present?
  end

  def vote_for(user)
    votes.find_by_user_id(user.id)
  end

  def vote_result
    votes.select { |v| v.is_up? }.count - votes.select { |v| !v.is_up? }.count
  end

end

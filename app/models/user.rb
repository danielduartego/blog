class User < ActiveRecord::Base

  has_secure_password

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :votes, dependent: :nullify
  has_many :voted_posts, through: :votes, source: :post

  mount_uploader :image, ImageUploader

  # extend FriendlyId
  # friendly_id :full_name, use: :slugged

  def full_name
    "#{first_name} #{last_name}".strip
  end

end

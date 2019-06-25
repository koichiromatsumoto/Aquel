class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :rooms
  has_many :messages
  has_many :contacts, dependent: :destroy

  has_many :active_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 12 }
  validates :introduction, length: { maximum: 100 }
  validates :status, inclusion: { in: [true, false] }
  validates :admin, inclusion: { in: [true, false] }

# 論理削除したユーザアカウントをログインできなくする
  def active_for_authentication?
      super && self.status?
  end

# フォローするメソッド
  def follow(other_user)
    unless self == other_user
      following << other_user
    end
  end

# フォロー解除のメソッド
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

# フォローしているかどうかを確認するメソッド
  def following?(other_user)
    following.include?(other_user)
  end
end

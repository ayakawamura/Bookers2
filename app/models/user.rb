class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  # relationのアソシエーション
  has_many :active_follows,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  has_many :passive_follows,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  
  has_many :followers,through: :active_follows,source: :followed
  has_many :followeds,through: :passive_follows,source: :follower
  
    # ユーザーをフォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end
  # フォロー確認をおこなう
  def following?(user)
   followers.include?(user)
  end
  
  # 名前２文字〜２０まで　同じ名前でsign_upはできない
  validates :name,length: {minimum:2,maximum:20},uniqueness: true
  validates :introduction,length:{maximum:50}
end

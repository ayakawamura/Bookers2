class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  # 中間テーブル（relation）目線ののアソシエーション
  # followed （フォローされる人）
  # フォローされてる人を取得
  has_many :followed,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  # そのうち自分をフォローしてる人(自分がフォローされている人)
  has_many :follower_user,through: :followed, source: :follower
  
  # follower （フォローする人）の記述
  # フォローしてる人取得  
  has_many :follower,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  # 自分がフォローしてる人
  has_many :following_user,through: :follower, source: :followed

    # ユーザーをフォローする関数
    # フォローされる人のid=user_id
  def follow(user_id)
   follower.create(followed_id: user.id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user.id).destroy
  end
  # フォロー確認をおこなう
  def following?(user)
   following_user.include?(user)
  end
  
  # 名前２文字〜２０まで　同じ名前でsign_upはできない
  validates :name,length: {minimum:2,maximum:20},uniqueness: true
  validates :introduction,length:{maximum:50}
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  # 中間テーブル（relation）目線のアソシエーション
  # followed （フォローされる人）
  # フォローされてる人を取得
  has_many :reverse_of_relationships,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  # そのうち自分をフォローしてる人(自分がフォローされている人)
  has_many :follower_user,through: :reverse_of_relationships , source: :follower
  
  # follower （フォローしてる側）の記述
  # userとrelationship繋ぐ 
  has_many :relationships,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  #フォローしてる人を取得 中間テーブルとfollowerを繋ぐ
  has_many :following_user,through: :relationships, source: :followed

    # ユーザーをフォローする関数
    # フォローされる人のid=user_id
  def follow(other_user)
   unless self==other_user
       self.relationships.find_or_create_by(followed_id: other_user.id)
   end
  end
  # ユーザーのフォローを外す
  def unfollow(other_user)
   relationship = self.relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end
  # フォロー確認をおこなう
  def following?(other_user)
   self.following_user.include?(other_user)
  end
 
  
  # 名前２文字〜２０まで　同じ名前でsign_upはできない
  validates :name,length: {minimum:2,maximum:20},uniqueness: true
  validates :introduction,length:{maximum:50}
end

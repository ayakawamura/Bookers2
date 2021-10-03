class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  # 中間テーブルのアソシエーション
  # follower （フォローする側）の記述
  # userとrelationship繋ぐ 　自分がフォローした→相手のフォロワーになったので「follower_id」
  has_many :relationships,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
  #フォローしてる人を取得するための記述 中間テーブルとfollowerを繋ぐ
  # フォローしてる側目線　自分がフォローしてる人＝followed(自分にフォローされてる人たち)
  has_many :following_user,through: :relationships, source: :followed

  # followed （フォローされる人）
  has_many :reverse_of_relationships,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy
  # 自分をフォローしてる人(自分がフォローされている人)
  has_many :follower_user,through: :reverse_of_relationships , source: :follower
  
  
    # ユーザーをフォローする関数
    # self=大体current_user
  def follow(other_user)
   unless self == other_user
       self.relationships.find_or_create_by(followed_id: other_user.id)
       # followed_idにother_user.idを入れる（コントローラで@user取得）
   end
  end
  # ユーザーのフォローを外す
  def unfollow(other_user)
   # idが２つの時はfind_by
   relationship = self.relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end
  # フォロー確認をおこなう
  def following?(other_user)
   self.following_user.include?(other_user)
  end
  
  # 検索フォームの分岐
  def self.looks(search, word)
    if search == "perfect_match"
      User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backword_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
 
  
  # 名前２文字〜２０まで　同じ名前でsign_upはできない
  validates :name,length: {minimum:2,maximum:20},uniqueness: true
  validates :introduction,length:{maximum:50}
end

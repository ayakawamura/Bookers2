class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  # 名前２文字〜２０まで　同じ名前でsign_upはできない
  validates :name,length: {minimum:2,maximum:20},uniqueness: true
  validates :introduction,length:{maximum:50}
end

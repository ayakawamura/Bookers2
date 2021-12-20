class Book < ApplicationRecord

	belongs_to :user
	has_many :book_comments,dependent: :destroy
  has_many :view_counts, dependent: :destroy

# 	いいね機能のアソシエーション
	has_many :favorites,dependent: :destroy
	  # いいねしたuserを探すときはいいねモデルを中間テーブルにする（無くてもいい）
  has_many :favorite_users,through: :favorites,source: :user

# いいね機能で使うメソッドを定義　favoriteした人（user_id）にuser.idを入れる
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title,presence: true
	validates :body,presence: true,length:{maximum:200}

	# 検索フォームの分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backword_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end

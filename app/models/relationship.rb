class Relationship < ApplicationRecord
	# follower フォローする人
	# followed フォローされる人
	belongs_to :follower,class_name:"User"
	belongs_to :followed,class_name:"User"
	validates :follower_id, presence: true
	validates :followed_id, presence: true
end

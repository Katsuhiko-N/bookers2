class Book < ApplicationRecord
    # アソシエーション
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :notifications, as: :notifiable, dependent: :destroy
    
    # バリデーション
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: {maximum: 200}
    
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    
    after_create do
        user.followings.each do |following|
            notifications.create(user_id: following.id)
        end
    end
    
end

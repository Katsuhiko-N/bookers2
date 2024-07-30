class Book < ApplicationRecord
    # アソシエーション
    belongs_to :user
    
    # バリデーション
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: {maximum: 200}
    
end

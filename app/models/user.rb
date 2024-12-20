class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_one_attached :profile_image
         
        # アソシエーション
         has_many :books, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :notifications, dependent: :destroy
         
         has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :followers, through: :follower_relationships, source: :followed
         
         has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :followings, through: :followed_relationships, source: :follower
         
         
         
         # バリデーション
         validates :name, presence: true
         validates :name, uniqueness: true
         validates :name, length: {minimum: 2, maximum: 20}
         validates :introduction, length: {maximum: 50}
         
         
         def get_profile_image(width, height)
             unless profile_image.attached?
                #  どこのファイル引っ張ってくる
                 file_path = Rails.root.join('app/assets/images/no_image.jpg')
                 profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
             end
             profile_image.variant(resize_to_limit:[width, height]).processed
         end
         
         
         def followed_by?(user, followed)
          followed_relationships.exists?(follower_id: user.id, followed_id: followed.id)
         end
         
         # フォロワー人数
         def followed_count(user) 
          return Relationship.where(followed_id: user.id).count
         end
         
         # フォロー人数
         def follower_count(user) 
          return Relationship.where(follower_id: user.id).count
         end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_one_attached :profile_image
         
        # アソシエーション
         has_many :books, dependent: :destroy
         
         # バリデーション
         validates :name, presence: true
         validates :name, length: {minimam: 2, maximum: 20}
         # validates :introduction, presence: true
         # validates :introduction, length: {maximum: 50}
         # validates :profile_image, presence: true
         
         
         def get_profile_image(width, height)
             unless profile_image.attached?
                #  どこのファイル引っ張ってくる
                 file_path = Rails.root.join('app/assets/images/no_image.jpg')
                 profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
             end
             profile_image.variant(resize_to_limit:[width, height]).processed
         end
         
end

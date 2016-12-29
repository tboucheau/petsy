class Post < ApplicationRecord

    belongs_to :user

    has_image :image, resize: '940x530'

    validates :name, :content, prensence: true
    validates :image_file, presence: true, on: :create

end

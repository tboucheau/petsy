class Pet < ApplicationRecord
    belongs_to :user
    belongs_to :species, counter_cache: true

    has_and_belongs_to_many :posts

    validates :name, :gender, :birthday, presence: true
    validates :gender, format: {with: /\A(M|F)\z/}
    validates :avatar_file, presence: true, on: :create
    validate :birthday_not_future

    has_image :avatar

    def age
        Time.now.year - birthday.year
    end

    def birthday_not_future
        if birthday.present? && birthday.future?
            errors.add(:birthday, 'ne peut être dans le futur')
        end
    end
end

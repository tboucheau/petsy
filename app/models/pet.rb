class Pet < ApplicationRecord
    belongs_to :user
    belongs_to :species

    validates :name, :gender, :birthday, presence: true
    validates :gender, format: {with: /\A(M|F)\z/}
    validates :birthday_not_future


    def birthday_not_future
        if birthday.present? && birthday.future?
            errors.add(:birthday, 'ne peut être dans le futur')
        end
    end
end

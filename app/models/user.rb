class User < ApplicationRecord

    has_secure_password
    validates :username,
        format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'ne doit contenir que des caractères alphanumériques ou des _'},
        uniqueness: {case_sensitive: false}

    validates :email,
        format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
        uniqueness: {case_sensitive: false}

end

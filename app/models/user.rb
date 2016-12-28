class User < ApplicationRecord

    attr_accessor :avatar_file
    has_secure_password
    has_secure_token :confirmation_token

    after_save :avatar_after_upload

    validates :username,
        format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'ne doit contenir que des caractères alphanumériques ou des _'},
        uniqueness: {case_sensitive: false}

    validates :email,
        format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
        uniqueness: {case_sensitive: false}

    validates :avatar_file, file: {ext: [:jpg, :png]}

    def to_session
        {id: id}
    end

    def avatar_after_upload
        path = File.join(
            Rails.public_path,
            self.class.name.downcase.pluralize,
            id.to_s,
            'avatar.jpg')
        if avatar_file.respond_to? :path
            dir = File.dirname(path)
            FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
            FileUtils.cp(avatar_file.path, path)
        end
    end

end

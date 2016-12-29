module ImageConcern

    extend ActiveSupport::Concern

    module ClassMethods
        def has_image(field, options = {})
            attr_accessor "#{field}_file".to_sym
            validates "#{field}_file".to_sym, file: {ext: [:jpg, :png]}
        end
    end

end

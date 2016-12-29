module ImageConcern

    extend ActiveSupport::Concern

    module ClassMethods
        def has_image(field, options = {})
            attr_accessor "#{field}_file".to_sym
            validates "#{field}_file".to_sym, file: {ext: [:jpg, :png]}
            #before_save "#{field}_file_before_upload".to_sym
            #after_save "#{field}_file_after_upload".to_sym
            #after_destroy "#{field}_file_commit _destroy".to_sym

            class_eval <<- METHODS


            METHODS
        end
    end

end

module ImageConcern

    extend ActiveSupport::Concern

    module ClassMethods
        def has_image(field, options = {})
            options[:resize] = '150x150!' if options[:resize].nil?

            attr_accessor "#{field}_file".to_sym
            validates "#{field}_file".to_sym, file: {ext: [:jpg, :png]}
            before_save "#{field}_before_upload".to_sym
            after_save "#{field}_after_upload".to_sym
            after_destroy_commit "#{field}_destroy".to_sym

            class_eval <<-METHODS, __FILE__, __LINE__ + 1
                def #{field}_url
                    '/uploads/' + [
                    self.class.name.downcase.pluralize,
                    id.to_s,
                    '#{field}.jpg'
                    ].join('/')
                end

                def #{field}_path
                    File.join(
                    Rails.public_path,
                    'uploads',
                    self.class.name.downcase.pluralize,
                    id.to_s,
                    '#{field}.jpg'
                    )
                end

              private

                def #{field}_after_upload
                    path = #{field}_path
                    options = #{options}
                    if #{field}_file.respond_to? :path
                        dir = File.dirname(path)
                        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
                        image = MiniMagick::Image.new(#{field}_file.path) do |b|
                            b.resize '#{options[:resize].delete('!')}^'
                            if options.end_with('!')
                                b.gravity 'Center'
                                b.crop '#{options[:resize].delete('!')}+0+0'
                            end
                        end
                        image.format 'jpg'
                        image.write path
                    end
                end

                def #{field}_before_upload
                    if #{field}_file.respond_to?(:path) and self.respond_to?(:#{field})
                        self.#{field} = true
                    end
                end

                def #{field}_destroy
                    dir = File.dirname(#{field}_path)
                    FileUtils.rm_r(dir) if Dir.exist?(dir)
                end

            METHODS
        end
    end

end

module AutotaskRuby
    # handles loading associated entities.
    module Association
        # loads parent entity.
        # Thanks to scoop for this example.
        def belongs_to(name, options = {})
            name = name.to_s
            klass = "#{(options[:class_name] || name).to_s.classify}"
            foreign_key = name.foreign_key
            define_singleton_method(name) do
                find(klass, send(foreign_key))
            end
        end

        # Example, an appointment can have one contact.
        # Thanks to scoop for this example.
        def has_one(name, options = {})
            name = name.to_s
            options.reverse_merge! foreign_key: self.to_s.foreign_key.camelize
            klass = "#{(options[:class_name] || name).to_s.classify}"
            define_singleton_method(name) do
                find(klass, options[:foreign_key], id).first
            end
        end

        # loads child entities.
        # Example: A project can have many tasks.
        # Thanks to scoop for this example.
        def has_many(name, options = {})
            name = name.to_s
            options.reverse_merge! foreign_key: self.to_s.foreign_key.camelize
            klass = "#{(options[:class_name] || name).to_s.classify}"
            define_singleton_method(name) do
                query(klass, options[:foreign_key], id)
            end
        end
    end
end

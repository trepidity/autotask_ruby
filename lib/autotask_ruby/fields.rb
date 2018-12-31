# frozen_string_literal: true

module AutotaskRuby
    # Converts Autotask Entity Fields into methods.
    module Fields
        def field(method_name)
            inst_variable_name = "@#{method_name}".to_sym
            define_method method_name do
                instance_variable_get inst_variable_name
            end
            define_method "#{method_name}=" do |new_value|
                instance_variable_set inst_variable_name, new_value
            end
        end
    end
end

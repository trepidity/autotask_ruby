# frozen_string_literal: true

module AutotaskRuby
    module Entity
        include AutotaskRuby::Constants

        def to_date_time(arg)
            Time.find_zone!('Eastern Time (US & Canada)').parse(arg)
        end

        def field_set(entity, field)
            node = entity.xpath("Autotask:#{field}", Autotask: NAMESPACE)

            # entity may not contain all fields that are possible.
            # Example: The entity may not have a contact specified.
            return if node.blank?

            return node.text.to_i if node.attr('type').blank?
            return node.text.to_i if node.attr('type').text.eql?('xsd:int')
            return to_date_time(node.text) if node.attr('type').text.eql?('xsd:dateTime')

            node.text if node.attr('type').text.eql?('xsd:string')
        end
    end
end

# frozen_string_literal: true

module AutotaskRuby
    # The base type for all objects represented by AutotaskRuby.
    # This module should extend any object type being used with AutoTask.
    module Entity
        include AutotaskRuby::Constants
        include AutotaskRuby::Association

        FIELDS = %i[id].freeze

        def self.included(base)
            base.const_set :FIELDS, Entity::FIELDS unless base.const_defined?(:FIELDS)
        end

        def initialize(options = {})
            @client = options if options.instance_of?(Client)
            return unless options.kind_of?(Hash)

            options.each do |k, v|
                instance_variable_set("@#{k}", v)
            end

            post_initialize
        end

        # default post_initialize methods.
        # Other classes that implement the Entity Class may override this.
        def post_initialize

        end

        # Iterates the fields of a Entity Class Type.
        # The fields are turned into instance variables.
        # Fields could include id, StartDateTime, Title, etc.
        def build(entity)
            self.class.const_get(:FIELDS).each do |field|
                instance_variable_set("@#{field}".underscore, field_set(entity, field))
            end
        end

        # updates the entity in the AutoTask API.
        # All fields are iterated and this builds the XML message that is sent to AutoTask.
        # Any field that is not filled out will be sent as empty. This means that it will wipe
        # any value that AutoTask has for that field.
        def update
            @client.soap_client.call(:update, message: "<Entity xsi:type=\"#{self.class.to_s.demodulize}\">#{fields_to_xml}</Entity>")
        end

        # creates an entity in AutoTask.
        def create
            result = @client.soap_client.call(:create, message: "<Entity xsi:type=\"#{self.class.to_s.demodulize}\">#{fields_to_xml}</Entity>")
            CreateResponse.new(@client, result)
        end

        # converts the AutoTask dateTime string value to a ActiveSupport::TimeWithZone object.
        # All dateTimes in AutoTask are in the Eastern Timezone.
        def to_date_time(arg)
            Time.find_zone!('Eastern Time (US & Canada)').parse(arg)
        end

        # Converts the specified field in the AutoTask XML response to the entity object field/attribute.
        # @param
        # - entity
        # - field
        def field_set(entity, field)
            node = entity.xpath("Autotask:#{field}", Autotask: AutotaskRuby.configuration.namespace)

            # entity may not contain all fields that are possible.
            # Example: The entity may not have a contact specified.
            return if node.blank?

            return node.text.to_i if node.attr('type').blank? || node.attr('type').text.eql?('xsd:int')
            return to_date_time(node.text) if node.attr('type').text.eql?('xsd:dateTime')
            return node.text.to_f if node.attr('type').text.eql?('xsd:double')

            node.text
        end

        def to_bool(arg)
            return true if arg == true || arg =~ (/(true|t|yes|y|1)$/i)
            return false if arg == false || arg.empty? || arg =~ (/(false|f|no|n|0)$/i)
            raise ArgumentError.new("invalid value for Boolean: \"#{arg}\"")
        end

        # converts the entity attributes to XML representation.
        # This is used when sending the object to the AutoTask API.
        def fields_to_xml
            str = ++''

            self.class.const_get(:FIELDS).each do |field|
                obj = instance_variable_get("@#{field}".underscore)
                next unless obj

                str << format_field_to_xml(field, obj)
            end
            str
        end

        # Returns the specified field as an XML element for the XML Body.
        # I.E. <id>xxx</id>
        # @param field_name
        #   the field name
        # @param field_value
        #   the field value.
        def format_field_to_xml(field_name, field_value)
            return "<#{field_name}>#{field_value.strftime(AUTOTASK_TIME_FORMAT)}</#{field_name}>" if field_value.instance_of?(ActiveSupport::TimeWithZone)

            "<#{field_name}>#{field_value}</#{field_name}>"
        end
    end
end

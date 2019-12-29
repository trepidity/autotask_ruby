# frozen_string_literal: true

module AutotaskRuby
  # The base type for all objects in AutoTask.
  # This module should extend any object type being used with AutoTask.
  module Entity
    include AutotaskRuby::Constants

    FIELDS = %i[id].freeze

    def self.included(base)
      base.const_set :FIELDS, Entity::FIELDS unless base.const_defined?(:FIELDS)
    end

    def initialize(options = {})
      options.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    def build(entity)
      self.class.const_get(:FIELDS).each do |field|
        instance_variable_set("@#{field}".underscore, field_set(entity, field))
      end
    end

    def update
      @client.client.call(:update, message: "<Entity xsi:type=\"#{self.class.to_s.demodulize}\">#{fields_to_xml}</Entity>")
    end

    def to_date_time(arg)
      Time.find_zone!('Eastern Time (US & Canada)').parse(arg)
    end

    def field_set(entity, field)
      node = entity.xpath("Autotask:#{field}", Autotask: NAMESPACE)

      # entity may not contain all fields that are possible.
      # Example: The entity may not have a contact specified.
      return if node.blank?

      return node.text.to_i if node.attr('type').blank? || node.attr('type').text.eql?('xsd:int')
      return to_date_time(node.text) if node.attr('type').text.eql?('xsd:dateTime')

      node.text
    end

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

    # Converts Entity to XML "Entity" object.
    # Should be placed inside a "entities" XML node.
    def to_xml
      str = ++''
      str << "<Entity xsi:type=\"#{self.class.to_s.demodulize}\">"
      instance_variables.each do |var|
        name = "#{var}".gsub('@', '').classify
        str << "<#{name}>"
        str << instance_variable_get("#{var}".underscore).to_s
        str << "</#{name}>"
      end
      str << "</Entity>"
      str
    end
  end
end

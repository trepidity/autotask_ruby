# frozen_string_literal: true

module AutotaskRuby

    # Represents an AutoTask Appointment Entity
    class Appointment
        include Entity

        FIELDS = %i[id Title Description ResourceID StartDateTime EndDateTime CreateDateTime UpdateDateTime].freeze
        .each do |field|
            self.attr_accessor :"#{field.to_s.underscore}"
        end

        def post_initialize
            belongs_to :resource
        end

    end

end

# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity ServiceCallTicketResource
  class ServiceCallTicketResource
    include Entity

    FIELDS = %i[id ServiceCallTicketID ResourceID].freeze
                                                  .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end
  end
end

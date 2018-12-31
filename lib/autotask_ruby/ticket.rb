# frozen_string_literal: true

module AutotaskRuby
    # Represents the Autotask Entity Ticket
    class Ticket
        include Entity

        FIELDS = %i[id AccountID ContactID CreateDate Description DueDateTime LastActivityDate AssignedResourceID Status TicketNumber Title].freeze
        .each do |field|
            self.attr_accessor :"#{field.to_s.underscore}"
        end

        def post_initialize
            belongs_to :account
            belongs_to :contact
        end
    end
end

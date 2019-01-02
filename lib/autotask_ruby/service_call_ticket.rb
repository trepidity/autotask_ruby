module AutotaskRuby
    # Represents the Autotask Entity ServiceCallTicket
    class ServiceCallTicket
        include Entity

        FIELDS = %i[id ServiceCallID TicketID].freeze
        .each do |field|
            self.attr_accessor :"#{field.to_s.underscore}"
        end
    end
end

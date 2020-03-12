# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity ServiceCall
  class ServiceCall
    include Entity
    include Query

    FIELDS = %i[id AccountID StartDateTime EndDateTime Description Complete CreateDateTime LastModifiedDateTime Duration Status].freeze
                 .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    # Returns the associated ResourceID.
    def resource_id
      service_call_ticket = find('ServiceCallTicket', 'ServiceCallId', id)

      unless service_call_ticket.nil?
        service_call_ticket_resource = find('ServiceCallTicketResource', 'ServiceCallTicketId', service_call_ticket.id)
        return service_call_ticket_resource.resource_id unless service_call_ticket_resource.nil?
      end

      nil
    end

    # Returns the associated Resource
    def resource
      find('Resource', resource_id)
    end

    # Returns the associated Account
    def account
      find('Account', account_id)
    end
  end
end

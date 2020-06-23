# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Ticket
  class Ticket
    include Entity
    include Query

    FIELDS = %i[id AccountID ContactID CreateDate Description DueDateTime LastActivityDate AssignedResourceID Status TicketNumber Title].freeze
                                                                                                                                        .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    # Returns the associated Account
    def account
      find('Account', account_id)
    end

    # Returns the associated Contact
    def contact
      find('Contact', contact_id)
    end
  end
end

# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Contact
  class Contact
    include Entity

    FIELDS = %i[id Active AddressLine City Country CreateDate EMailAddress Extension FirstName AccountID LastName MobilePhone Phone State Title ZipCode].freeze
                                                                                                                                                        .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      belongs_to :account
    end

    def full_name
      [@first_name, @last_name].join(' ')
    end

    def email
      @e_mail_address
    end
  end
end

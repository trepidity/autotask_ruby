module AutotaskRuby
  class Contact
    include Entity

    FIELDS = %i[id Active AddressLine City Country EMailAddress FirstName AccountID LastName MobilePhone Phone State Title ZipCode].freeze
    attr_accessor :id, :active, :addressLine, :city, :country, :email_address, :first_name, :account_id, :last_name,
                  :mobile_phone, :phone, :state, :title, :zip_code
  end
end

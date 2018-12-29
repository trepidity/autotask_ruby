# frozen_string_literal: true

module AutotaskRuby
    class Resource
        include AutotaskRuby::Entity
        include AutotaskRuby::Query

        FIELDS = %i[id Email Email2 Email3 FirstName HomePhone Initials LastName LocationID MiddleName
                    MobilePhone OfficeExtension OfficePhone ResourceType Title UserName UserType Active].freeze
        attr_accessor :id, :email, :first_name, :last_name, :user_name, :active

        def initialize(client)
            @client = client
        end

        def build(entity)
            FIELDS.each do |field|
                instance_variable_set("@#{field}".underscore, field_set(entity, field))
            end
        end

        def account_to_dos
            query('AccountToDo', 'AssignedToResourceID', @id)
        end
    end
end

# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Resource
  class Resource
    include AutotaskRuby::Entity
    include AutotaskRuby::Query

    FIELDS = %i[id Email Email2 Email3 FirstName HomePhone Initials LastName LocationID MiddleName
                    MobilePhone OfficeExtension OfficePhone ResourceType Title UserName UserType Active].freeze
                 .each do |field|
      self.attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      has_many :account_to_dos, foreign_key: 'AssignedToResourceID'
      has_many :appointments, foreign_key: 'ResourceID'
      has_many :tickets, foreign_key: 'AssignedResourceID'
      has_many :tasks, foreign_key: 'AssignedResourceID'
    end
  end
end

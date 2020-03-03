# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask AccountToDo entity
  class AccountToDo
    include AutotaskRuby::Entity
    include AutotaskRuby::Query

    FIELDS = %i[id AccountID ContactID ActivityDescription StartDateTime EndDateTime
                AssignedToResourceID CreateDateTime LastModifiedDate ActionType].freeze
             .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      belongs_to :resource
      belongs_to :account
    end

    def contact
      find('Contact', contact_id)
    end

    def action
      find('ActionType', action_type)
    end

  end
end

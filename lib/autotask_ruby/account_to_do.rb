# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask AccountToDo entity
  class AccountToDo
    include AutotaskRuby::Entity
    include AutotaskRuby::Query

    FIELDS = %i[id AccountID ContactID ActivityDescription StartDateTime EndDateTime
                AssignedToResourceID ActionType CreateDateTime LastModifiedDate].freeze
             .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      belongs_to :resource
      belongs_to :account
    end
  end
end

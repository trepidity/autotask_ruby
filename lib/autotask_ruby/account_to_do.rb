# frozen_string_literal: true

module AutotaskRuby
    class AccountToDo
        include Entity

        FIELDS = %i[id AccountID ContactID ActivityDescription StartDateTime EndDateTime
                    AssignedToResourceID ActionType CreateDateTime LastModifiedDate].freeze
        attr_accessor :id, :account_id, :contact_id, :activity_description, :start_date_time, :end_date_time,
                      :assigned_to_resource_id, :action_type, :create_date_time, :last_modified_date

        def initialize(client)
            @client = client
        end

        def build(entity)
            FIELDS.each do |field|
                instance_variable_set("@#{field}".underscore, field_set(entity, field))
            end
        end

        def save
            # TODO: save to autotask
        end
    end
end

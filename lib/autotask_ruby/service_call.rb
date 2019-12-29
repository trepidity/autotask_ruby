module AutotaskRuby
  class ServiceCall
    include Entity

    FIELDS = %i[id AccountID StartDateTime EndDateTime Description Complete CreatorResourceID CreateDateTime LastModifiedDateTime Status].freeze
    attr_accessor :id, :account_id, :start_date_time, :end_date_time, :description, :complete, :creator_resource_id, :create_date_time, :last_modified_date_time, :status

  end
end
# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Project
  class Project
    include Entity

    FIELDS = %i[id ProjectName AccountID Type ProjectNumber Description CreateDateTime StartDateTime
                EndDateTime Duration EstimatedTime Status ProjectLeadResourceID StatusDetail StatusDateTime].freeze
             .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      has_many :tasks
      belongs_to :account
    end
  end
end

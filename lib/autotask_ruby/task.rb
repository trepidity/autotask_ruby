# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Task
  class Task
    include Entity

    FIELDS = %i[id AllocationCodeID AssignedResourceID CreateDateTime DepartmentID Description EstimatedHours
        LastActivityDateTime ProjectID Status TaskNumber TaskType Title ].freeze
                 .each do |field|
      self.attr_accessor :"#{field.to_s.underscore}"
    end

    def post_initialize
      belongs_to :resource
      belongs_to :project
    end
  end
end

# frozen_string_literal: true

module AutotaskRuby

  # Represents an AutoTask Task Entity
  class Task
    include Entity

    FIELDS = %i[id Title Description AssignedResourceID DepartmentID EstimatedHours StartDateTime EndDateTime CreateDateTime UpdateDateTime
                        LastActivityDateTime ProjectID Status TaskNumber TaskType ].freeze
    attr_accessor :id, :title, :description, :start_date_time, :end_date_time, :create_date_time, :update_date_time, :assigned_resource_id,
                  :department_id, :estimated_hours, :last_activity_date_time, :project_id, :status, :task_number, :task_type

  end

end

# frozen_string_literal: true

module AutotaskRuby

  # Represents an AutoTask Appointment Entity
  class Appointment
    include Entity

    FIELDS = %i[id Title Description ResourceID StartDateTime EndDateTime CreateDateTime UpdateDateTime].freeze
    attr_accessor :id, :title, :description, :start_date_time, :end_date_time, :resource_id, :create_date_time, :update_date_time

  end

end

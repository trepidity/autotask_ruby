# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Entity Action Type
  class ActionType
    include Entity

    FIELDS = %i[id Name View Active SystemActionType].freeze
                                                     .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end
  end
end

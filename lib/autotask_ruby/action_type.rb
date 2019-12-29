# frozen_string_literal: true

module AutotaskRuby

  # Represents an AutoTask ActionType Entity
  class ActionType
    include Entity

    FIELDS = %i[id Name View Active SystemActionType].freeze
    attr_accessor :id, :name, :view, :active, :system_action_type

  end

end

# frozen_string_literal: true

module AutotaskRuby
  # Represents the Autotask Account Entity
  class Account
    include Entity

    FIELDS = %i[id Address1 City Country CreateDate AccountName AccountNumber Phone PostalCode State Active].freeze
                                                                                                            .each do |field|
      attr_accessor :"#{field.to_s.underscore}"
    end
  end
end

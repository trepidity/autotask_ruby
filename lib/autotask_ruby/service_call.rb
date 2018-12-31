module AutotaskRuby
    # Represents the Autotask Entity ServiceCall
    class ServiceCall
        include Entity

        FIELDS = %i[id AccountID StartDateTime EndDateTime Description Complete CreateDateTime LastModifiedDateTime Duration Status].freeze
        .each do |field|
            self.attr_accessor :"#{field.to_s.underscore}"
        end
    end
end

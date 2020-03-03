# frozen_string_literal: true

module AutotaskRuby
  module Query
    def query(entity_type, field = 'id', op = 'equals', value)
      result = @client.soap_client.call(:query, message: "<sXML><![CDATA[<queryxml><entity>#{entity_type}</entity><query><field>#{field}<expression op=\"#{op}\">#{value}</expression></field></query></queryxml>]]></sXML>")
      AutotaskRuby::QueryResponse.new(@client, result)
    end

    # @param entity, id
    #   pass in the entity_type, I.E. AccountToDo, Resource, etc. and the ID of the entity.
    # @return Entity
    # Returns a single Entity if a match was found.
    # Returns nil if no match is found.
    def find(entity, field = 'id', id)
      response = query(entity, field, id)
      return nil if response.entities.empty?

      response.entities.first
    end
  end
end

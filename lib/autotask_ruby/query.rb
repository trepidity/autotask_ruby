# frozen_string_literal: true

module AutotaskRuby
  module Query
    # Queries the API with the specified QueryXML object.
    # The QueryXML can contain x number of arguments that build the CDATA query string.
    # You must pass in a QueryXML object.
    # @param :QueryXML
    # @return Response.
    def query_for(query)
      result = @client.call(:query, message: query)
      AutotaskRuby::Response.new(@client, result)
    end

    def query(entity_type, field = 'id', op = 'equals', value)
      result = @client.call(:query, message: "<sXML><![CDATA[<queryxml><entity>#{entity_type}</entity><query><field>#{field}<expression op=\"#{op}\">#{value}</expression></field></query></queryxml>]]></sXML>")
      AutotaskRuby::Response.new(@client, result)
    end
  end
end

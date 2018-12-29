# frozen_string_literal: true

module AutotaskRuby
    module Query
        def query(entity_type, field = 'id', op = 'equals', value)
            result = @client.soap_client.call(:query, message: "<sXML><![CDATA[<queryxml><entity>#{entity_type}</entity><query><field>#{field}<expression op=\"#{op}\">#{value}</expression></field></query></queryxml>]]></sXML>")
            AutotaskRuby::QueryResponse.new(@client, result)
        end
    end
end

# frozen_string_literal: true

require 'autotask_ruby/version'
require 'autotask_ruby/resource'

module AutotaskRuby
  # the primary client that interfaces with the SOAP Client that will interface with AutoTask.
  class Client
    attr_accessor :soap_client, :headers, :logger

    def initialize(options = {})
      @headers = {
        'tns:AutotaskIntegrations' =>
            {
              'tns:IntegrationCode' => options[:integration_code]
            }
      }

      @ssl_version = options[:ssl_version] || :TLSv1_2
      @endpoint = options[:endpoint] || 'https://webservices.autotask.net/ATServices/1.5/atws.asmx'

      # Override optional Savon attributes
      savon_options = {}
      %w[read_timeout open_timeout proxy raise_errors log_level basic_auth log raise_errors].each do |prop|
        key = prop.to_sym
        savon_options[key] = options[key] if options.key?(key)
      end

      @soap_client = Savon.client({
        wsdl: './atws.wsdl',
        soap_header: @headers,
        namespaces: { xmlns: AutotaskRuby.configuration.namespace },
        logger: Logger.new($stdout),
        raise_errors: false,
        log: true,
        endpoint: @endpoint,
        ssl_version: @ssl_version # Sets ssl_version for HTTPI adapter
      }.update(savon_options))
    end

    # Public: Get the names of all wsdl operations.
    # List all available operations from the atws.wsdl
    def operations
      @soap_client.operations
    end

    # @param entity, id
    #   pass in the entity_type, I.E. AccountToDo, Resource, etc. and the ID of the entity.
    # @return Entity
    # Returns a single Entity if a match was found.
    # Returns nil if no match is found.
    def find(entity, id)
      response = query(entity.to_s, id)

      return nil if response.entities.empty?

      response.entities.first
    end

    # @param entity_type and value
    # Other parameters, are optional.
    #   full set of parameters include entity_type, field, operation, value.
    # Queries the Autotask QUERY API. Returns a QueryResponse result set.
    # @return AutotaskRuby::Response.
    def query(entity_type, field = 'id', operation = 'equals', value)
      result = @soap_client.call(:query, message: "<sXML><![CDATA[<queryxml><entity>#{entity_type}</entity><query><field>#{field}<expression op=\"#{operation}\">#{value}</expression></field></query></queryxml>]]></sXML>")
      AutotaskRuby::QueryResponse.new(self, result)
    end

    # @param entity_type
    #   include the entity type. ServiceCall, Appointment, etc.
    # @param ids
    #   One or more entity ID's that should be deleted.
    # @return
    #   AutotaskRuby::DeleteResponse
    def delete(entity_type, *ids)
      entities = ++''
      ids.each do |id|
        entities << "<Entity xsi:type=\"#{entity_type}\"><id xsi:type=\"xsd:int\">#{id}</id></Entity>"
      end
      resp = @soap_client.call(:delete, message: "<Entities>#{entities}</Entities>")
      AutotaskRuby::DeleteResponse.new(@client, resp)
    end

    def query_for(message)
      result = @soap_client.call(:query, message: message)
      AutotaskRuby::QueryResponse.new(self, result)
    end

    # updates the entity in the AutoTask API.
    # All fields are iterated and this builds the XML message that is sent to AutoTask.
    # Any field that is not filled out will be sent as empty. This means that it will wipe
    # any value that AutoTask has for that field.
    def update(entity_xml)
      result = @soap_client.call(:update, message: "<Entities>#{entity_xml}</Entities>")
      UpdateResponse.new(@client, result)
    end

    # creates an entity in AutoTask.
    def create(entity_xml)
      result = @soap_client.call(:create, message: "<Entities>#{entity_xml}</Entities>")
      CreateResponse.new(@client, result)
    end

    def threshold_and_usage_info
      result = @soap_client.call(:get_threshold_and_usage_info)
      ThresholdAndUsageInfoResponse.new(@client, result)
    end
  end
end

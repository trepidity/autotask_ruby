# frozen_string_literal: true

require 'autotask_ruby/version'
require 'autotask_ruby/resource'

module AutotaskRuby

    # the primary client that interfaces with the SOAP Client that will interface with AutoTask.
    class Client
        NAMESPACE = 'http://autotask.net/ATWS/v1_5/'
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
                namespaces: { xmlns: NAMESPACE },
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
            AutotaskRuby::QueryResponse.new(@client, result)
        end

    end
end

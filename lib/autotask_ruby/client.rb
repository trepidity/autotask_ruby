# frozen_string_literal: true

require 'autotask_ruby/version'
require 'autotask_ruby/resource'

module AutotaskRuby
  class Client
    include Query

    NAMESPACE = 'http://autotask.net/ATWS/v1_5/'
    attr_accessor :client, :headers, :logger

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

      @client = Savon.client({
                                 wsdl: './atws.wsdl',
                                 soap_header: @headers,
                                 namespaces: {xmlns: NAMESPACE},
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
      @client.operations
    end

    def threshold_and_usage_info
      resp = @client.call(:get_threshold_and_usage_info)
      return_code = resp.xpath('//Autotask:ReturnCode', Autotask: NAMESPACE).text.to_i
      message = resp.xpath('//Autotask:Message', Autotask: NAMESPACE).text
      errors = resp.xpath('//Autotask:Errors', Autotask: NAMESPACE).text

      unless errors.blank? || return_code.positive?
        raise errors
      end

      message
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

    def create(xml)
      result = @client.call(:create, message: xml, attributes: {xmlns: NAMESPACE})
      AutotaskRuby::Response.new(@client, result)
    end

    def create_entity(entity)
      result = @client.call(:create, message: "<Entities>#{entity.to_xml}</Entities>", attributes: {xmlns: NAMESPACE})
      AutotaskRuby::Response.new(@client, result)
    end

    def update(xml)
      result = @client.call(:update, message: xml, attributes: {xmlns: NAMESPACE})
      AutotaskRuby::Response.new(@client, result)
    end

    def delete_by_id(entity_type, id)
      result = @client.call(:delete, message: "<Entity xsi:type=\"#{entity_type}\"><id xsi:type=\"xsd:int\">#{id}</id></Entity>",
                            attributes: {xmlns: NAMESPACE})
      AutotaskRuby::Response.new(@client, result)
    end
  end
end

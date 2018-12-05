require "autotask_ruby/version"

module AutotaskRuby
    class Client
        NAMESPACE = 'http://autotask.net/ATWS/v1_5/'
        attr_accessor :client, :headers, :logger

        def initialize(options = {})
            @headers = {}

            @ssl_version = options[:ssl_version] || :TLSv1_2
            @logger = options[:logger] || true
            @endpoint = options[:login_url] || "https://webservices2.autotask.net/ATServices/1.6/atws.asmx"

            # Override optional Savon attributes
            savon_options = {}
            %w(read_timeout open_timeout proxy raise_errors).each do |prop|
                key = prop.to_sym
                savon_options[key] = options[key] if options.key?(key)
            end

            @client = Savon.client({
                                       wsdl: "./atws.wsdl",
                                       soap_header: @headers,
                                       convert_request_keys_to: :none,
                                       convert_response_tags_to: @response_tags,
                                       pretty_print_xml: true,
                                       filters: @filters,
                                       logger: @logger,
                                       log: (@logger),
                                       endpoint: @endpoint,
                                       ssl_version: @ssl_version # Sets ssl_version for HTTPI adapter
                                   }.update(savon_options))
        end

        # Public: Get the names of all wsdl operations.
        # List all available operations from the partner.wsdl
        def operations
            @client.operations
        end

        def zone_info
            @client.call(:get_zone_info, message: {'UserName' => 'jjennings@jaredjenningsdemo.com'})
        end

    end
end

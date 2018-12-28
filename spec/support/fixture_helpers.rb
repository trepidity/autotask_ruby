# frozen_string_literal: true

# shameless stolen from https://github.com/TinderBox/soapforce/blob/master/spec/support/fixture_helpers.rb
# Thank you for your great work.

module FixtureHelpers
    module InstanceMethods
        def stub_zone_info_request(options = {})
            options = {
                method: :post,
                status: 200
            }.merge(options)

            instance_url = options[:instance_url] || 'https://webservices.autotask.net/ATServices/1.5/atws.asmx'
            stub_request(options[:method], instance_url)
                .with(body: options[:query_xml], headers: zone_info_http_headers)
                .to_return(status: 200, body: fixture(options[:fixture]), headers: {})
        end

        def stub_api_request(options = {})
            options = {
                method: :post,
                status: 200
            }.merge(options)

            instance_url = options[:instance_url] || 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx'
            stub_request(options[:method], instance_url)
                .with(body: http_body(options[:query_xml]), headers: http_headers(options))
                .to_return(status: 200, body: fixture(options[:fixture]), headers: {})
        end

        def fixture(f)
            File.read(File.expand_path("../../fixtures/#{f}.xml", __FILE__))
        end

        def http_body(query_xml)
            # be very careful with this block.
            # the trailing spaces are required for webmock to work.
            body = <<~EOF
                <?xml version="1.0" encoding="UTF-8"?>
                <env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
                xmlns:tns="http://autotask.net/ATWS/v1_5/" 
                xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" 
                xmlns="http://autotask.net/ATWS/v1_5/">
                <env:Header><tns:AutotaskIntegrations>
                <tns:IntegrationCode>BDKQY55L24ANTHTRZXDVQKKQWS</tns:IntegrationCode>
                </tns:AutotaskIntegrations></env:Header>
                <env:Body>
                #{query_xml}
                </env:Body>
                </env:Envelope>
            EOF
            body.delete("\n")
        end

        def zone_info_http_headers
            { :Accept => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Length' => '375',
              'Content-Type' => 'text/xml;charset=UTF-8',
              :Soapaction => '"http://autotask.net/ATWS/v1_5/getZoneInfo"',
              'User-Agent' => 'Ruby' }
        end

        def http_headers(options = {})
            {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type' => 'text/xml;charset=UTF-8',
                'Soapaction' => (options[:soap_action]).to_s || '"http://autotask.net/ATWS/v1_5/query"',
                'User-Agent' => 'Ruby'
            }
        end

        def soap_headers(params = {})
            return '' if params.nil? || params.empty?

            headers = '<env:Header>'
            headers << "<tns:CallOptions><tns:client>#{params[:client_id]}</tns:client></tns:CallOptions>" if params[:client_id]
            headers << "<tns:SessionHeader><tns:sessionId>#{params[:session_id]}</tns:sessionId></tns:SessionHeader>" if params[:session_id]
            headers << '</env:Header>'
        end
    end
end

RSpec.configure do |config|
    config.include FixtureHelpers::InstanceMethods
end

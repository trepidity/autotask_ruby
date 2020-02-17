# frozen_string_literal: true

# shameless stolen from https://github.com/TinderBox/soapforce/blob/master/spec/support/fixture_helpers.rb
# Thank you for your great work.

module FixtureHelpers
  module InstanceMethods
    def stub_client
      AutotaskRuby::Client.new(basic_auth: %w[api_user@autotaskdemo.com something],
                               integration_code: ENV['INTEGRATION_CODE'],
                               endpoint: 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx',
                               log: false)
    end

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

    def time_with_zone
      Time.find_zone!('Eastern Time (US & Canada)')
    end

    def stub_api_request(options = {})
      options = {
        method: :post,
        status: 200
      }.merge(options)

      instance_url = options[:instance_url] || 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx'
      stub_request(options[:method], instance_url)
        .to_return(status: 200, body: fixture(options[:fixture]), headers: {})
    end

    def fixture(f)
      File.read(File.expand_path("../../fixtures/#{f}.xml", __FILE__))
    end

    def http_body(env_headers, query_xml)
      # be very careful with this block.
      # the trailing spaces are required for webmock to work.
      body = <<~EOF
        <?xml version="1.0" encoding="UTF-8"?>
        <env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:tns="http://autotask.net/ATWS/v1_5/"
        xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
        xmlns="http://autotask.net/ATWS/v1_5/">
        #{soap_headers(env_headers)}
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
        'Soapaction' => options[:soap_action] ||= '"http://autotask.net/ATWS/v1_5/query"',
        'User-Agent' => 'Ruby'
      }
    end

    def soap_headers(params = {})
      return '' if params.nil? || params.empty?

      headers = ++''
      headers << '<env:Header>'
      headers << "<tns:AutotaskIntegrations><tns:IntegrationCode>#{params[:integration_code]}</tns:IntegrationCode></tns:AutotaskIntegrations>"
      headers << '</env:Header>'
    end
  end
end

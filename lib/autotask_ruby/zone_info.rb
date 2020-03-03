# frozen_string_literal: true

module AutotaskRuby
  class ZoneInfo
    attr_reader :raw_result

    ENDPOINT = 'https://webservices.autotask.net/ATServices/1.5/atws.asmx'

    def initialize(username)
      @client = Savon.client(wsdl: './atws.wsdl', endpoint: ENDPOINT)
      @raw_result = @client.call(:get_zone_info, message: { 'UserName' => username })
      @zone_info = @raw_result.body[:get_zone_info_response][:get_zone_info_result]
    end

    def error_code
      @zone_info[:error_code].to_i
    end

    def web_url
      @zone_info[:web_url]
    end

    def url
      @zone_info[:url]
    end

    # @param [Object] method
    # @param [Array] _args
    # @return [Object]
    def method_missing(method, *_args)
      @zone_info[method]
    end
  end
end

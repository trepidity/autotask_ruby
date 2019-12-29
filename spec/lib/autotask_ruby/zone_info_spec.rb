# frozen_string_literal: true

require 'rspec'

RSpec.describe AutotaskRuby::ZoneInfo do
  let(:body) { '<?xml version="1.0" encoding="UTF-8"?><env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tns="http://autotask.net/ATWS/v1_5/" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body><tns:getZoneInfo><tns:UserName>jared@jaredjenningsdemo.com</tns:UserName></tns:getZoneInfo></env:Body></env:Envelope>' }
  let(:valid_url) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
  let(:valid_web_url) { 'https://ww2.autotask.net/' }
  let(:subject) { described_class.new('jared@jaredjenningsdemo.com') }

  before do
    stub_zone_info_request(query_xml: body, fixture: 'zone_info_response')
  end

  describe 'web_url' do
    it { expect(subject.web_url).to eql(valid_web_url) }
  end

  describe 'service url' do
    it { expect(subject.url).to eql(valid_url) }
  end
end

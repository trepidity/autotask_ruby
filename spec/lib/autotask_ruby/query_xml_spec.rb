# frozen_string_literal: true

require 'rspec'

RSpec.describe AutotaskRuby::QueryXML do
  let(:stubbed_request) { '<tns:query><sXML><![CDATA[<queryxml>  <entity>Appointment</entity>  <query>    <field>id<expression op="equals">1208</expression></field>  </query></queryxml>]]></sXML></tns:query>' }
  let(:query) {
    AutotaskRuby::QueryXML.new do |query|
      query.entity = 'Appointment'
      query.field = 'id'
      query.op = 'equals'
      query.expression = '1208'
    end
  }
  let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
  let(:valid_api_user) { 'api_user@autotaskdemo.com' }
  let(:valid_password) { 'something' }
  let(:client) do
    AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                             integration_code: ENV['INTEGRATION_CODE'],
                             endpoint: endpoint)
  end
  let(:result) { client.query_for(query) }

  before do
    stub_api_request(query_xml: stubbed_request, fixture: 'appointment_response',
                     env_headers: {integration_code: ENV['INTEGRATION_CODE']})
  end

  it { expect(result.entities.first.id).to eql(1209) }

end

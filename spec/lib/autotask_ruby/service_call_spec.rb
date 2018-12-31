# frozen_string_literal: true

RSpec.describe AutotaskRuby::Contact do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>ServiceCall</entity><query><field>id<expression op="equals">337</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:client) { stub_client }
    let(:result) { client.find('ServiceCall', 337) }

    before do
        stub_api_request(query_xml: body, fixture: 'query_service_call_response',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(result.id).to eql(337) }
    it { expect(result.account_id).to eql(29684280) }
    it { expect(result.description).to eql('new Service Call') }
    it { expect(result.complete).to eql(0) }
    it { expect(result.status).to eql(1) }
    it { expect(result.duration).to eql(1.0) }
    it { expect(result.start_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-20 09:00:00 -0500')) }
    it { expect(result.end_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-20 10:00:00 -0500')) }
    it { expect(result.last_modified_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-19 12:19:55 -0500')) }

end

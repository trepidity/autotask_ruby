# frozen_string_literal: true

RSpec.describe AutotaskRuby::Account do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>Account</entity><query><field>id<expression op="equals">296162</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:client) { stub_client }
    let(:result) { client.find('Account', 296162) }

    before do
        stub_api_request(query_xml: body, fixture: 'account_response',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(result.id).to eql(296162) }
    it { expect(result.account_name).to eql('ABLE Manufacturing*') }
    it { expect(result.address1).to eql('163 Consaul Road') }
    it { expect(result.city).to eql('Albany') }
    it { expect(result.country).to eql('United States') }
    it { expect(result.active).to be_truthy }

end

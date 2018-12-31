# frozen_string_literal: true

require 'rspec'

RSpec.describe AutotaskRuby::QueryResponse do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>AccountToDo</entity><query><field>id<expression op="equals">29684510</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:client) { stub_client }

    context 'when successfully found an account_to_do' do
        let(:result) { client.find('AccountToDo', 29_684_510) }

        before do
            stub_api_request(query_xml: body, fixture: 'account_to_do_response',
                             env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it { expect(result.account_id).to eql(296_162) }
        it { expect(result.contact_id).to eql(296_409) }
        it { expect(result.start_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-11 08:37:00.000000000 -0500')) }
        it { expect(result.end_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-11 09:27:00.000000000 -0500')) }
        it { expect(result.activity_description).to eql('Placeat officiis deserunt. Et magnam voluptatem. Dolor qui rerum.') }
    end
end

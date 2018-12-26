# frozen_string_literal: true

RSpec.describe AutotaskRuby::AccountToDo do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>AccountToDo</entity><query><field>id<expression op="equals">29684510</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
    let(:valid_api_user) { 'api_user@autotaskdemo.com' }
    let(:valid_password) { 'something' }
    let(:client) do
        AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                 integration_code: 'BDKQY55L24ANTHTRZXDVQKKQWS',
                                 endpoint: endpoint)
    end
    let(:subject) { client.find('AccountToDo', 29_684_510) }

    before do
        stub_api_request(query_xml: body, fixture: 'account_to_do_response')
    end

    it { expect(subject.id).to eql(29_684_510) }
    it { expect(subject.account_id).to eql(296_162) }
    it { expect(subject.contact_id).to eql(296_409) }
    it { expect(subject.assigned_to_resource_id).to eql(29_684_250) }
    it { expect(subject.action_type).to eql(295_993) }
    it { expect(subject.activity_description).to eql('Placeat officiis deserunt. Et magnam voluptatem. Dolor qui rerum.') }
    it { expect(subject.start_date_time).to be_within(1.second).of(Time.find_zone!('Eastern Time (US & Canada)').parse('2018-11-11 08:37:00.000000000 -0500')) }
    it { expect(subject.create_date_time).to be_within(1.second).of(Time.find_zone!('Eastern Time (US & Canada)').parse('2018-11-11 08:27:09.267000000 -0500')) }
    it { expect(subject.last_modified_date).to be_within(1.second).of(Time.find_zone!('Eastern Time (US & Canada)').parse('2018-11-11 08:27:09.267000000 -0500')) }
end

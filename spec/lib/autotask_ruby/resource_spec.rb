# frozen_string_literal: true

RSpec.describe :resource do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>resource</entity><query><field>id<expression op="equals">29684250</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
    let(:valid_api_user) { 'api_user@autotaskdemo.com' }
    let(:valid_password) { 'something' }
    let(:client) do
        AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                 integration_code: 'BDKQY55L24ANTHTRZXDVQKKQWS',
                                 endpoint: endpoint)
    end
    let(:subject) { client.find(:resource, 29_684_250) }

    context 'resource' do
        before do
            stub_api_request(query_xml: body, fixture: 'query_resource_response')
        end

        it { expect(subject.first_name).to eql('Raymond') }
        it { expect(subject.last_name).to eql('Jennings') }
        it { expect(subject.user_name).to eql('rjennings') }
        it { expect(subject.email).to eql('rspecninjatools@example.com') }
    end

    # context 'when a resource has account_to_dos' do
    #     let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>AccountToDo</entity><query><field>AssignedToResourceID<expression op="equals">29684250</expression></field></query></queryxml>]]></sXML></tns:query>' }
    #
    #     before do
    #         stub_api_request({query_xml: body, fixture: 'query_resource_account_to_do_response'})
    #     end
    #
    #     it { expect(subject.account_to_dos.size).to eql(1) }
    # end
end
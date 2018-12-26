# frozen_string_literal: true

module AutotaskRuby
    describe Client do
        let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
        let(:valid_api_user) { 'api_user@autotaskdemo.com' }
        let(:valid_password) { 'something' }

        URL = 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx'
        WEBURL = 'https://ww2.autotask.net/'
        VALID_USERNAME = 'jared@jaredjenningsdemo.com'

        describe 'operations' do
            let(:subject) { AutotaskRuby::Client.new }

            it { expect(subject.operations).to be_an(Array) }
            it { expect(subject.operations).to include(:query) }
        end

        describe 'query objects' do
            BODY = '<tns:query><sXML><![CDATA[<queryxml><entity>Resource</entity><query><field>LastName<expression op="equals">jennings</expression></field></query></queryxml>]]></sXML></tns:query>'

            let(:client) do
                AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                         endpoint: endpoint,
                                         integration_code: 'BDKQY55L24ANTHTRZXDVQKKQWS')
            end
            let(:subject) { client.query('Resource', 'LastName', 'equals', 'jennings') }

            before do
                stub_api_request(query_xml: BODY, fixture: 'query_response')
            end

            it { expect(subject).to be_instance_of(QueryResponse) }
            it { expect(subject.entity_type).to eq('Resource') }
            it { expect(subject.entities.last.id).to eql(29_684_250) }
            it { expect(subject.entities.last.email).to eql('rspecninjatools@example.com') }
            it { expect(subject.entities.last.first_name).to eql('Raymond') }
            it { expect(subject.entities.last.last_name).to eql('Jennings') }
        end
    end
end

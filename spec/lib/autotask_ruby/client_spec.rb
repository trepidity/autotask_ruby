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
            let(:client) { AutotaskRuby::Client.new }

            it { expect(client.operations).to be_an(Array) }
            it { expect(client.operations).to include(:query) }
        end

        describe 'query objects' do
            BODY = '<tns:query><sXML><![CDATA[<queryxml><entity>Resource</entity><query><field>LastName<expression op="equals">jennings</expression></field></query></queryxml>]]></sXML></tns:query>'

            let(:client) do
                AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                         endpoint: endpoint,
                                         integration_code: ENV['INTEGRATION_CODE'])
            end
            let(:query) { client.query('Resource', 'LastName', 'equals', 'jennings') }

            before do
                stub_api_request(query_xml: BODY, fixture: 'query_response',
                                 soap_action: '"http://autotask.net/ATWS/v1_5/query"',
                                 env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
            end

            it { expect(query).to be_instance_of(QueryResponse) }
            it { expect(query.entity_type).to eq('Resource') }
            it { expect(query.entities.last.id).to eql(29_684_250) }
            it { expect(query.entities.last.email).to eql('rspecninjatools@example.com') }
            it { expect(query.entities.last.first_name).to eql('Raymond') }
            it { expect(query.entities.last.last_name).to eql('Jennings') }
        end

    end
end

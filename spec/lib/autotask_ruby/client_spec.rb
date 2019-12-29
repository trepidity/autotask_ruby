# frozen_string_literal: true

module AutotaskRuby
    describe Client do
        let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
        let(:valid_api_user) { 'api_user@autotaskdemo.com' }
        let(:valid_password) { 'something' }
        let(:client) do
            AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                     endpoint: endpoint,
                                     integration_code: ENV['INTEGRATION_CODE'])
        end

        describe 'operations' do
            let(:client) { AutotaskRuby::Client.new }

            it { expect(client.operations).to be_an(Array) }
            it { expect(client.operations).to include(:query) }
        end

        describe 'query objects' do
            BODY = '<tns:query><sXML><![CDATA[<queryxml><entity>Resource</entity><query><field>LastName<expression op="equals">jennings</expression></field></query></queryxml>]]></sXML></tns:query>'
            let(:query) { client.query('Resource', 'LastName', 'equals', 'jennings') }

            before do
                stub_api_request(query_xml: BODY, fixture: 'query_response',
                                 soap_action: '"http://autotask.net/ATWS/v1_5/query"',
                                 env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
            end

            it { expect(query).to be_instance_of(Response) }
            it { expect(query.entity_type).to eq('Resource') }
            it { expect(query.entities.last.id).to eql(29_684_250) }
            it { expect(query.entities.last.email).to eql('rspecninjatools@example.com') }
            it { expect(query.entities.last.first_name).to eql('Raymond') }
            it { expect(query.entities.last.last_name).to eql('Jennings') }
        end

        describe 'getThresholdAndUsageInfo' do
            let(:stubbed_request) { '<tns:getThresholdAndUsageInfo></tns:getThresholdAndUsageInfo>' }
            let(:usage_info) { client.threshold_and_usage_info }

            before do
                stub_api_request(query_xml: stubbed_request, fixture: 'threshold_and_usage_info_response',
                                 soap_action: '"http://autotask.net/ATWS/v1_5/getThresholdAndUsageInfo"',
                                 env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
            end

            it { expect(usage_info).to eql('ThresholdOfExternalRequest: 10000; TimeframeOfLimitation: 60; numberOfExternalRequest: 0;') }

        end

        describe 'create' do
            let(:stubbed_request) { '<tns:create xmlns="http://autotask.net/ATWS/v1_5/"><Entities><Entity xsi:type="Appointment"><Title>Pax8 integration to Autotask. For product</Title><Description>A new appointment</Description><ResourceId>29684250</ResourceId><StartDateTime>2018-11-17T22:22:28</StartDateTime><EndDateTime>2018-11-17T23:22:28</EndDateTime></Entity></Entities></tns:create>' }
            let(:appointment) { AutotaskRuby::Appointment.new(title: 'Pax8 integration to Autotask. For product',
                                                              description: 'A new appointment',
                                                              resource_id: 29684250,
                                                              start_date_time: '2018-11-17T22:22:28',
                                                              end_date_time: '2018-11-17T23:22:28')}
            before do
                stub_api_request(query_xml: stubbed_request, fixture: 'create_response',
                                 soap_action: '"http://autotask.net/ATWS/v1_5/create"',
                                 env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
            end
            let(:create) { client.create_entity(appointment) }

            it { expect(create.return_code).to be(1) }
            it { expect(create.entities.first.id).to be(8440) }
        end

    end
end

# frozen_string_literal: true

RSpec.describe AutotaskRuby::Task do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>Task</entity><query><field>id<expression op="equals">9282</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:client) { stub_client }
    let(:result) { client.find('Task', 9282) }

    before do
        stub_api_request(query_xml: body, fixture: 'query_tasks_response',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(result.id).to eql(9282) }
    it { expect(result.project_id).to eql(105) }
    it { expect(result.status).to eql(15) }

end

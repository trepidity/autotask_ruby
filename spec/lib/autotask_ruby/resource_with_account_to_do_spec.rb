require 'rspec'

RSpec.describe 'ResourceWithAccountToDos' do
    let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>AccountToDo</entity><query><field>AssignedToResourceID<expression op="equals">29684250</expression></field></query></queryxml>]]></sXML></tns:query>' }
    let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
    let(:valid_api_user) { 'api_user@autotaskdemo.com' }
    let(:valid_password) { 'something' }
    let(:client) do
        AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                 integration_code: ENV['INTEGRATION_CODE'],
                                 endpoint: endpoint)
    end
    let(:resource) { AutotaskRuby::Resource.new(client) }
    let(:result) { resource.account_to_dos }

    before do
        stub_api_request(query_xml: body, fixture: 'query_resource_account_to_do_response',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it 'has two account_to_dos' do
        resource.id = 29684250
        expect(result.entities.size).to eql(2)
    end

end
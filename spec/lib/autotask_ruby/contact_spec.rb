RSpec.describe AutotaskRuby::Contact do
  let(:body) { '<tns:query><sXML><![CDATA[<queryxml><entity>Contact</entity><query><field>id<expression op="equals">29684281</expression></field></query></queryxml>]]></sXML></tns:query>' }
  let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
  let(:valid_api_user) { 'api_user@autotaskdemo.com' }
  let(:valid_password) { 'something' }
  let(:client) do
    AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                             integration_code: ENV['INTEGRATION_CODE'],
                             endpoint: endpoint)
  end

  context 'when a new instance' do
    let(:result) { described_class.new(client: client) }

    it { expect(result).to be_an_instance_of(described_class) }
  end

  describe 'find' do
    let(:find) { client.find('Contact', 29684281) }

    before do
      stub_api_request(query_xml: body, fixture: 'contact_response',
                       soap_action: '"http://autotask.net/ATWS/v1_5/query"',
                       env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(find.id).to be(29_684_281) }
    it { expect(find.first_name).to eql('Maria') }

  end

end
# frozen_string_literal: true

RSpec.describe AutotaskRuby::Contact do
  let(:client) { stub_client }
  let(:result) { client.find('Contact', 29_684_281) }

  before do
    stub_api_request(fixture: 'query_contact_response',
                     env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
  end

  it { expect(result.id).to be(29_684_281) }
  it { expect(result.address_line).to eql('1901 Chouteau Avenue') }
  it { expect(result.e_mail_address).to eql('MRevels@example.com') }
  it { expect(result.city).to eql('Saint Louis') }
  it { expect(result.state).to eql('MO') }
  it { expect(result.country).to eql('United States') }
  it { expect(result.active).to be_truthy }
end

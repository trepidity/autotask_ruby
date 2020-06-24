# frozen_string_literal: true

RSpec.describe AutotaskRuby::Account do
  let(:client) { stub_client }
  let(:result) { client.find('Account', 296_162) }

  before do
    stub_api_request(fixture: 'account_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
  end

  it { expect(result.id).to be(296_162) }
  it { expect(result.account_name).to eql('ABLE Manufacturing*') }
  it { expect(result.address1).to eql('163 Consaul Road') }
  it { expect(result.city).to eql('Albany') }
  it { expect(result.country).to eql('United States') }
  it { expect(result.postal_code).to eql('12205') }
  it { expect(result.state).to eql('NY') }
  it { expect(result.active).to be_truthy }
end

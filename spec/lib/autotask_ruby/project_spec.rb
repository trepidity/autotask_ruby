# frozen_string_literal: true

RSpec.describe AutotaskRuby::Project do
  let(:client) { stub_client }
  let(:result) { client.find('Project', 105) }

  before do
    stub_api_request(fixture: 'query_project_response',
                     env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
  end

  it { expect(result.id).to be(105) }
  it { expect(result.project_name).to eql('Sync 2.0') }
  it { expect(result.account_id).to be(29_684_280) }
  it { expect(result.project_number).to eql('P20180129.0001') }
  it { expect(result.duration).to be(66) }
  it { expect(result.status).to be(1) }
end

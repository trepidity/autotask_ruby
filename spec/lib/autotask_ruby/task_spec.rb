# frozen_string_literal: true

RSpec.describe AutotaskRuby::Task do
  let(:client) { stub_client }
  let(:result) { client.find('Task', 9282) }

  before do
    stub_api_request(fixture: 'query_tasks_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
  end

  it { expect(result.id).to be(9282) }
  it { expect(result.project_id).to be(105) }
  it { expect(result.status).to be(15) }
end

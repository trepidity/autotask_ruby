# frozen_string_literal: true

RSpec.describe AutotaskRuby::AccountToDo do
  let(:client) { stub_client }
  let(:result) { client.find('AccountToDo', 29_684_510) }

  before do
    stub_api_request(fixture: 'account_to_do_response', env_headers: {integration_code: ENV['INTEGRATION_CODE']})
  end

  it { expect(result.id).to eql(29_684_510) }
  it { expect(result.account_id).to eql(296_162) }
  it { expect(result.contact_id).to eql(296_409) }
  it { expect(result.assigned_to_resource_id).to eql(29_684_250) }
  it { expect(result.action_type).to eql(295_993) }
  it { expect(result.activity_description).to eql('Placeat officiis deserunt. Et magnam voluptatem. Dolor qui rerum.') }
  it { expect(result.start_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-11 08:37:00 -0500')) }
  it { expect(result.end_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-11 09:27:00 -0500')) }
  it { expect(result.create_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-11 08:27:09 -0500')) }
  it { expect(result.last_modified_date).to be_within(1.second).of(time_with_zone.parse('2018-11-11 08:27:09 -0500')) }

end

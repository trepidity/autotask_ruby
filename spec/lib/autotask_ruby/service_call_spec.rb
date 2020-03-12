# frozen_string_literal: true

RSpec.describe AutotaskRuby::Contact do
  let(:client) { stub_client }
  let(:result) { client.find('ServiceCall', 337) }

  before do
    stub_request(:post, 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx')
      .to_return({ status: 200, body: fixture('query_service_call_response') },
                 { status: 200, body: fixture('query_service_call_ticket_response') },
                 { status: 200, body: fixture('query_service_call_ticket_resource_response') },
                 status: 200, body: fixture('query_resource_response'))
  end

  it { expect(result.id).to be(337) }
  it { expect(result.account_id).to be(29_684_280) }
  it { expect(result.resource_id).to be(29_684_250) }
  it { expect(result.description).to eql('new Service Call') }
  it { expect(result.complete).to be(0) }
  it { expect(result.status).to be(1) }
  it { expect(result.duration).to be(1.0) }
  it { expect(result.start_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-20 09:00:00 -0500')) }
  it { expect(result.end_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-20 10:00:00 -0500')) }
  it { expect(result.last_modified_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-19 12:19:55 -0500')) }
  it { expect(result.resource).to be_instance_of(AutotaskRuby::Resource) }
  it { expect(result.resource.id).to be(29_684_250) }


  context 'when a ServiceCall is associated with an account' do
    describe 'it has an account name' do
      let(:result) { client.find('ServiceCall', 337) }

      before do
        stub_request(:post, 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx')
            .to_return({ status: 200, body: fixture('query_service_call_response') },
                       { status: 200, body: fixture('account_response') })
      end

      it { expect(result.account.account_name).to eql('ABLE Manufacturing*')}
      it { expect(result.account.id).to be(296_162)}
    end
  end
end

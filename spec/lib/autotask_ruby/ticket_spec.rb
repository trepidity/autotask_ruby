# frozen_string_literal: true

RSpec.describe AutotaskRuby::Contact do
  let(:client) { stub_client }
  let(:result) { client.find('Ticket', 9137) }

  before do
    stub_api_request(fixture: 'query_ticket_9137_response',
                     env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
  end

  it { expect(result.id).to eq(9137) }
  it { expect(result.account_id).to eq(29_684_280) }
  it { expect(result.contact_id).to eq(29_684_281) }
  it { expect(result.assigned_resource_id).to eq(29_684_291) }
  it { expect(result.status).to eq(1) }
  it { expect(result.ticket_number).to eql('T20180724.0001') }
  it { expect(result.title).to eql('Service Call Ticket for Testing') }

  context 'account' do
    describe 'has account details' do
      before do
        stub_request(:post, 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx')
         .to_return({ status: 200, body: fixture('query_ticket_9137_response') },
                    { status: 200, body: fixture('account_29_684_280_response') })
      end

      it { expect(result.account.id).to eq(29_684_280) }
      it { expect(result.account.account_name).to eq('My Utility Services') }
    end
  end

  context 'contact' do
    describe 'has contact details' do
      before do
        stub_request(:post, 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx')
         .to_return({ status: 200, body: fixture('query_ticket_9137_response') },
                    { status: 200, body: fixture('contact_response') })
      end

      it { expect(result.contact.id).to eq(29_684_281) }
      it { expect(result.contact.first_name).to eq('Maria') }
    end
  end
end

# frozen_string_literal: true

RSpec.describe AutotaskRuby::Resource do
    let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
    let(:client) { stub_client }
    let(:resource) { described_class.new(client: client, id: 29_684_250 ) }

    describe 'attributes' do
        let(:resource) { client.find(:resource, 29_684_250) }

        before do
            stub_api_request(fixture: 'query_resource_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it { expect(resource.first_name).to eql('Raymond') }
        it { expect(resource.last_name).to eql('Jennings') }
        it { expect(resource.user_name).to eql('rjennings') }
        it { expect(resource.email).to eql('rspecninjatools@example.com') }
    end

    describe 'resource with appointments' do
        let(:result) { resource.appointments }

        before do
            stub_api_request(fixture: 'query_resource_appointments_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it { expect(result).to be_instance_of(AutotaskRuby::QueryResponse) }
        it { expect(result.entity_type).to eql('Appointment') }
    end

    describe 'resource with tickets' do
        let(:result) { resource.tickets }

        before do
            stub_api_request(fixture: 'query_ticket_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it { expect(result).to be_instance_of(AutotaskRuby::QueryResponse) }
        it { expect(result.entity_type).to eql('Ticket') }
        it { expect(result.entities.last.title).to eql('Service Call Ticket for Testing') }
    end

    describe 'resource with tasks' do
        let(:result) { resource.tasks }

        before do
            stub_api_request(fixture: 'query_tasks_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it { expect(result).to be_instance_of(AutotaskRuby::QueryResponse) }
        it { expect(result.entity_type).to eql('Task') }
        it { expect(result.entities.first.title).to eql('Perspiciatis praesentium voluptatem ad.') }
    end

    describe 'resource with account_to_dos' do
        let(:endpoint) { 'https://webservices2.autotask.net/ATServices/1.5/atws.asmx' }
        let(:result) { resource.account_to_dos }

        before do
            stub_api_request(fixture: 'query_resource_account_to_do_response', env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
        end

        it 'has two account_to_dos' do
            resource.id = 29684250
            expect(result.entities.size).to eql(2)
        end
    end
end

# frozen_string_literal: true

RSpec.describe AutotaskRuby::Appointment do
  let(:client) { stub_client }

  context 'when a new instance' do
    let(:result) { described_class.new(client: client) }

    it { expect(result).to be_an_instance_of(described_class) }
  end

  describe 'create' do
    let(:appointment) do
      described_class.new(client: client, title: 'Optio accusantium quis nulla.',
                          start_date_time: time_with_zone.parse('2018-06-21 06:30:00 -0500'),
                          end_date_time: time_with_zone.parse('2018-06-21 07:30:00 -0500'))
    end
    let(:result) { appointment.create }

    before do
      stub_api_request(fixture: 'create_appointment_response',
                       soap_action: '"http://autotask.net/ATWS/v1_5/create"',
                       env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(result.entities.first.id).to be(6732) }
    it { expect(result.entity_type).to eql('Appointment') }
  end

  context 'when updating' do
    let(:appointment) do
      described_class.new(client: client, id: 1208, title: 'Optio accusantium quis nulla.',
                          start_date_time: time_with_zone.parse('2018-06-21 06:30:00 -0500'),
                          end_date_time: time_with_zone.parse('2018-06-21 07:30:00 -0500'))
    end
    let(:result) { appointment.update }

    before do
      stub_api_request(fixture: 'appointment_response',
                       soap_action: '"http://autotask.net/ATWS/v1_5/update"',
                       env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(appointment.title).to eql('Optio accusantium quis nulla.') }
    it { expect(result).to be_truthy }
  end

  describe 'find' do
    let(:find) { client.find('Appointment', 1209) }

    before do
      stub_api_request(fixture: 'appointment_response',
                       soap_action: '"http://autotask.net/ATWS/v1_5/query"',
                       env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
    end

    it { expect(find.id).to be(1209) }
    it { expect(find.resource_id).to be(29_684_250) }
    it { expect(find.title).to eql('Optio accusantium quis nulla.') }
    it { expect(find.description).to eql('Numquam sapiente atque. Quisquam doloribus at. Rerum ut est.') }
    it { expect(find.start_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-17 22:32:00 -0500')) }
    it { expect(find.end_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-17 23:22:00 -0500')) }
    it { expect(find.create_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-17 22:22:28 -0500')) }
    it { expect(find.update_date_time).to be_within(1.second).of(time_with_zone.parse('2018-11-17 22:22:28 -0500')) }
  end
end

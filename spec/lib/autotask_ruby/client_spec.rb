# frozen_string_literal: true

module AutotaskRuby
  describe Client do
    let(:client) { stub_client }

    describe 'operations' do
      let(:client) { described_class.new }

      it { expect(client.operations).to be_an(Array) }
      it { expect(client.operations).to include(:query) }
      it { expect(client.operations).to include(:get_threshold_and_usage_info) }
    end

    context 'when get_threshold_and_usage_info' do
      before do
        stub_api_request(fixture: 'threshold_and_usage_info_response',
                         soap_action: '"http://autotask.net/ATWS/v1_5/getThresholdAndUsageInfo"',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
      end

      describe 'return_code' do
        it { expect(client.threshold_and_usage_info.return_code).to be(1) }
      end
    end

    describe 'delete' do
      let(:result) { client.delete('ServiceCall', 271) }

      before do
        stub_api_request(fixture: 'delete_response',
                         soap_action: '"http://autotask.net/ATWS/v1_5/delete"',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
      end

      it { expect(result).to be_instance_of(DeleteResponse) }
      it { expect(result.return_code).to be(1) }
    end

    describe 'query objects' do
      let(:query) { client.query('Resource', 'LastName', 'equals', 'jennings') }

      before do
        stub_api_request(fixture: 'query_response',
                         soap_action: '"http://autotask.net/ATWS/v1_5/query"',
                         env_headers: { integration_code: ENV['INTEGRATION_CODE'] })
      end

      it { expect(query).to be_instance_of(QueryResponse) }
      it { expect(query.entity_type).to eq('Resource') }
      it { expect(query.entities.last.id).to be(29_684_250) }
      it { expect(query.entities.last.email).to eql('rspecninjatools@example.com') }
      it { expect(query.entities.last.first_name).to eql('Raymond') }
      it { expect(query.entities.last.last_name).to eql('Jennings') }
    end
  end
end

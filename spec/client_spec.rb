RSpec.describe AutotaskRuby::Client do
    let(:subject) { AutotaskRuby::Client.new }

    it 'has an array of operations' do
        expect(subject.operations).to be_an(Array)
    end

    it 'has a query operation' do
        expect(subject.operations).to include(:query)
    end

    #
    # it "has a valid URL" do
    #     result = client.zone_info
    #     expect(result.body[:get_zone_info_response][:get_zone_info_result][:url]).to eql("https://webservices2.autotask.net/ATServices/1.6/atws.asmx")
    # end
    #
    # it 'includes the query operation' do
    #     expect(subject.operations).to be_an(Array)
    # end


end

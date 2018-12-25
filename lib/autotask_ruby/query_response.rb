# frozen_string_literal: true

module AutotaskRuby
    class QueryResponse
        include Constants
        attr_accessor :entity_type, :errors, :return_code, :entities

        def initialize(client, response)
            @client = client
            @entities = []
            @errors = response.xpath('//Autotask:Errors', Autotask: NAMESPACE).text
            @return_code = response.xpath('//Autotask:ReturnCode', Autotask: NAMESPACE).text.to_i
            @entity_type = response.xpath('//Autotask:EntityResultType', Autotask: NAMESPACE).text.classify
            parse_entities(response.xpath('//Autotask:Entity', Autotask: NAMESPACE))
        end

        private

        def parse_entities(results)
            return [] if results.blank?

            klass = ('AutotaskRuby::' + results.first.attribute('type').to_s).constantize
            results.collect do |entity|
                obj = klass.new(@client)
                obj.build(entity)
                @entities.push(obj)
            end
        end
    end
end

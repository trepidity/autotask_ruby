# frozen_string_literal: true

module AutotaskRuby
  class Configuration
    attr_accessor :integration_code
    attr_accessor :version
    attr_accessor :namespace

    def initialize
      @integration_code = nil
      @version = 1.5
      @namespace = 'http://autotask.net/ATWS/v1_5/'
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

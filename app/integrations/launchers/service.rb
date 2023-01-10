# frozen_string_literals: true

module Launchers
  class Service
    def initialize
      @client = Launchers::Client.new
    end

    def import_data(params)
      @client.get(params)
    end
  end
end

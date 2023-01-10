# frozen_string_literals: true

module Launchers
  class Client
    include HTTParty

    ENDPOINT = 'https://ll.thespacedevs.com/2.0.0/launch/'
    private_constant :ENDPOINT

    def get(params)
      self.class.get(ENDPOINT, query: params)
    end
  end
end

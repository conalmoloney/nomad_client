require 'faraday'
require 'faraday_middleware'
module NomadClient
  class Connection

    attr_accessor :configuration

    def initialize(url, config = Configuration.new)
      config.url = url
      yield(config) if block_given?
      @configuration = config
    end

    def connection
      @connection ||= ::Faraday.new({ url: connection_url, ssl: configuration.ssl }) do |faraday|
        faraday.request(:json)
        faraday.use(FaradayMiddleware::Mashify)
        faraday.response(:json, :content_type => /\bjson$/)
        faraday.options.timeout = 5
        faraday.options.open_timeout = 2
        faraday.adapter :net_http_persistent, pool_size: 5 do |http|
          http.idle_timeout = 100
          http.retry_change_requests = true
        end
      end
    end

    def connection_url
      "#{configuration.url}:#{configuration.port}#{configuration.api_base_path}"
    end
  end
end

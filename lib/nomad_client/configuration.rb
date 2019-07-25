module NomadClient
  class Configuration
    # FQDN of the Nomad you're talking to, e.g: https://nomad.local
    attr_accessor :url

    # Nomad's bound port, by default this is 4646
    attr_accessor :port

    # Nomad's HTTP API base path, as of writing this is /v1
    attr_accessor :api_base_path

    # SSL configuration hash, specifically the one Faraday expects,
    # see https://gist.github.com/mislav/938183 for a quick example
    attr_accessor :ssl

    DEFAULT_PORT          = 4646.freeze
    DEFAULT_API_BASE_PATH = '/v1'.freeze
    DEFAULT_SSL           = {}.freeze
    TIMEOUT               = 5
    OPEN_TIMEOUT          = 2
    POOL_SIZE             = 5
    IDLE_TIMEOUT          = 100
    RETRY_CHANGE_REQUESTS = true
    RETRY_MAX             = 3
    RETRY_INTERVAL        = 1.0
    RETRY_RANDOMNESS      = 0.5
    RETRY_BACKOFF_FACTOR  = 2.0

    def initialize
      @port                  = DEFAULT_PORT
      @api_base_path         = DEFAULT_API_BASE_PATH
      @ssl                   = DEFAULT_SSL
      @timeout               = TIMEOUT
      @open_timeout          = OPEN_TIMEOUT
      @pool_size             = POOL_SIZE
      @idle_timeout          = IDLE_TIMEOUT
      @retry_change_requests = RETRY_CHANGE_REQUESTS
      @retry_max             = RETRY_MAX
      @retry_interval        = RETRY_INTERVAL
      @retry_randomness      = RETRY_RANDOMNESS
      @retry_backoff_factor  = RETRY_BACKOFF_FACTOR
    end
  end
end

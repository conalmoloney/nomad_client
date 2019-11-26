module NomadClient
  class Connection
    def metrics
      Api::Metrics.new(self)
    end
  end
  module Api
    class Metrics < Path

      ##
      # Lists all the deployments
      # https://www.nomadproject.io/api/deployments.html
      #
      # @param [String] prefix Specifies a string to filter deployments on based on an index prefix. This is specified as a querystring parameter.
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get(format: nil)
        connection.get do |req|
          req.url "metrics"
          req.params[:format] = format
        end
      end
    end
  end
end

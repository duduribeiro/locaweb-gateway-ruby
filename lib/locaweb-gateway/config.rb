require 'locaweb-gateway/null_logger'

module Locaweb
  module Gateway
    class Config
      # The class variable that represents the user token.
      #
      cattr_accessor :token
      self.token = ''

      # The class variable that represents the environment that the transaction will be processed
      # <b>OBS.:</b>: Defaults to production
      #
      cattr_accessor :environment
      self.environment = :production

      # If you overwrite the base_uri, just assign in config an diferent URI.
      #
      cattr_accessor :uri
      self.uri = ''

      # Adding logger on the request and response cycle.
      # Default is null logger (Don't log anything).
      #
      cattr_accessor :logger
      self.logger = ::Locaweb::Gateway::NullLogger.new

      # TODO: put ssl and the request object should read from this.
      #
      # cattr_accessor :ssl, :ssl_client_cert, :ssl_client_key, :ssl_ca_file
      # self.ssl = false
      #
      # Returns the base endpoint for the Locaweb Payment Gateway.
      # You can overwrite passing in the uri accessor.
      #
      def self.base_uri
        return uri if uri.present?

        if environment.equal?(:production)
          'https://api.gatewaylocaweb.com.br/v1/transacao'
        else
          'https://api-sandbox.gatewaylocaweb.com.br/v1/transacao'
        end
      end

      def self.configure(&block)
        block.call(self)
      end
    end
  end
end

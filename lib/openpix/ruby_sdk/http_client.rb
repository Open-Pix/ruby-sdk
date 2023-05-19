# frozen_string_literal: true

require 'faraday'
require 'faraday/httpclient'

module Openpix
  module RubySdk
    # Application HTTP Client to make requests, it uses Faraday as the wrapper and defaults to STD Lib client (Net::HTTP)
    class HttpClient
      BASE_URL = 'https://api.woovi.com/api'
      API_VERSION = '/v1'

      attr_accessor :http_client

      def initialize
        @http_client = Faraday.new(
          url: "#{BASE_URL}#{API_VERSION}",
          headers: {
            'Authorization' => ENV['OPENPIX_APP_ID']
          }
        ) do |f|
          f.request :json
          f.response :json
          f.adapter :httpclient
        end
      end

      def post(resource, body:, headers: {}, params: {})
        @http_client.post(resource) do |request|
          request.params = params
          request.headers = request.headers.merge(headers)
          request.body = body
        end
      end
    end
  end
end

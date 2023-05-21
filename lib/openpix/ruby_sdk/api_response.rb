# frozen_string_literal: true

module Openpix
  module RubySdk
    # An Object representing the response from a call to Woovi API
    class ApiResponse
      attr_reader :success, :resource_response, :pagination_meta, :error_response

      def initialize(status:, resource_response: nil, error_response: nil, pagination_meta: {})
        @success = status == 200
        @resource_response = resource_response
        @pagination_meta = pagination_meta
        @error_response = error_response
      end
    end
  end
end

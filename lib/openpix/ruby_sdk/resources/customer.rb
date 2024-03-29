# frozen_string_literal: true

require 'openpix/ruby_sdk/resources/resource'
require 'openpix/ruby_sdk/api_body_formatter'

module Openpix
  module RubySdk
    module Resources
      # Make API operations on Customer resource
      class Customer < Resource
        ATTRS = %w[
          name
          email
          phone
          taxID
          correlationID
          address
        ].freeze

        attr_accessor(*ATTRS)

        # @param params [Hash{String => String, Number, Hash{String, Number}, Array<Hash{String, String}>}] the attributes for creating a Charge
        # @param rest [Hash] more attributes to be merged at the body, use this only for unsupported fields
        def init_body(params: {}, rest: {})
          super(base_attrs: ATTRS, params: params, rest: rest)
        end

        def create_attributes
          ATTRS
        end

        def to_url
          'customer'
        end

        def to_body
          body = super

          return body if body['address'].nil? || body['address'].empty?

          body['address'] = Openpix::RubySdk::ApiBodyFormatter.remove_empty_values(body['address'])

          body
        end

        # rubocop:disable Lint/UnusedMethodArgument
        def destroy(id:)
          raise(
            ActionNotImplementedError,
            'customer does not implement DELETE action'
          )
        end

        def destroy!(id:)
          raise(
            ActionNotImplementedError,
            'customer does not implement DELETE action'
          )
        end
        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/hash/except'

require 'openpix/ruby_sdk/resources/resource'

module Openpix
  module RubySdk
    module Resources
      # Make API operations on Payment resource
      class Payment < Resource
        ATTRS = %w[
          value
          destinationAlias
          correlationID
          comment
          sourceAccountId
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
          'payment'
        end

        # rubocop:disable Lint/UnusedMethodArgument
        def destroy(id:)
          raise(
            ActionNotImplementedError,
            'payment does not implement DELETE action'
          )
        end

        def destroy!(id:)
          raise(
            ActionNotImplementedError,
            'payment does not implement DELETE action'
          )
        end
        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end

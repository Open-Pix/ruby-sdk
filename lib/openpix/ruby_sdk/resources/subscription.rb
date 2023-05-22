# frozen_string_literal: true

require 'openpix/ruby_sdk/resources/resource'

module Openpix
  module RubySdk
    module Resources
      class Subscription < Resource
        ATTRS = %w[
          value
          day_generate_charge
          customer
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
          'subscriptions'
        end

        def to_single_resource
          'subscription'
        end

        def to_body
          body = super

          return body if body['customer'].nil? || body['customer'].empty?

          customer_parsed = {}
          body['customer'].each do |attr, value|
            customer_parsed[attr.camelize(:lower).gsub('Id', 'ID')] = value
          end

          body['customer'] = customer_parsed

          body
        end

        # rubocop:disable Lint/UnusedMethodArgument
        def fetch(skip: nil, limit: nil, extra_headers: {})
          raise(
            ActionNotImplementedError,
            'subscription does not implement GET index action'
          )
        end

        def fetch!(skip: nil, limit: nil, extra_headers: {})
          raise(
            ActionNotImplementedError,
            'subscription does not implement GET index action'
          )
        end

        def fetch_next_page!(extra_headers: {})
          raise(
            ActionNotImplementedError,
            'subscription does not implement GET index action'
          )
        end

        def fetch_previous_page!(extra_headers: {})
          raise(
            ActionNotImplementedError,
            'subscription does not implement GET index action'
          )
        end

        def destroy(id:)
          raise(
            ActionNotImplementedError,
            'subscription does not implement DELETE action'
          )
        end

        def destroy!(id:)
          raise(
            ActionNotImplementedError,
            'subscription does not implement DELETE action'
          )
        end
        # rubocop:enable Lint/UnusedMethodArgument
      end
    end
  end
end

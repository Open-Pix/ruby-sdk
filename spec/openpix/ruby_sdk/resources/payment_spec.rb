# frozen_string_literal: true

require_relative 'shared/savable_resource'
require_relative 'shared/fetchable_resource'
require_relative 'shared/findable_resource'
require_relative 'shared/not_destroyable_resource'
require 'openpix/ruby_sdk/resources/payment'

RSpec.describe Openpix::RubySdk::Resources::Payment do
  savable_params = {
    resource_class: described_class,
    attrs: {
      'value' => 54_005,
      'correlationID' => '1234',
      'sourceAccountId' => '123'
    },
    body_response: {
      'payment' => {
        'value' => 54_005,
        'status' => 'CREATED',
        'correlationID' => '1234',
        'sourceAccountId' => '123'
      }
    },
    error_response: {
      'error' => 'error from API charge'
    }
  }
  it_behaves_like 'savable resource', savable_params

  fetchable_params = {
    resource_class: described_class,
    body_response: {
      'customers' => [
        {
          'value' => 54_005,
          'status' => 'CREATED',
          'correlationID' => '1234',
          'sourceAccountId' => '123'
        }
      ]
    },
    error_response: {
      'error' => 'error from API charge'
    }
  }
  it_behaves_like 'fetchable resource', fetchable_params

  findable_params = {
    resource_class: described_class,
    body_response: {
      'customer' => {
        'value' => 54_005,
        'status' => 'CREATED',
        'correlationID' => '1234',
        'sourceAccountId' => '123'
      }
    },
    error_response: {
      'error' => 'error from API charge'
    }
  }
  it_behaves_like 'findable resource', findable_params

  it_behaves_like 'not destroyable resource', described_class

  let(:sourceAccountId) { nil }
  let(:attrs) do
    {
      'value' => 54_005,
      'correlationID' => '1234',
      'sourceAccountId' => sourceAccountId
    }
  end

  subject { described_class.new(double('http_client')) }

  it 'sets its url' do
    expect(subject.to_url).to eq('payment')
  end

  it 'defines its create attributes' do
    expect(subject.create_attributes).to eq(Openpix::RubySdk::Resources::Payment::ATTRS)
  end

  describe '#init_body' do
    it 'sets the attrs defined by the ATTRS constant' do
      subject.init_body(params: attrs)

      expect(subject.value).to eq(attrs['value'])
      expect(subject.correlationID).to eq(attrs['correlationID'])
      expect(subject.sourceAccountId).to eq(sourceAccountId)
      expect(subject.comment).to eq(nil)
    end
  end

  describe '#to_body' do
    before { subject.init_body(params: attrs) }

    context 'without sourceAccountId' do
      let(:expected_body) do
        {
          'value' => attrs['value'],
          'correlationID' => attrs['correlationID']
        }
      end

      it 'parses other fields normally' do
        expect(subject.to_body).to eq(expected_body)
      end
    end

    context 'with sourceAccountId' do
      let(:sourceAccountId) { '123' }
      let(:expected_body) do
        {
          'value' => attrs['value'],
          'correlationID' => attrs['correlationID'],
          'sourceAccountId' => attrs['sourceAccountId']
        }
      end

      it 'parses sourceAccountId as expected' do
        expect(subject.to_body).to eq(expected_body)
      end
    end
  end
end

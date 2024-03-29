# frozen_string_literal: true

require 'uri'

RSpec.shared_examples 'findable resource' do |params|
  let(:mocked_http_client) { double('http_client') }
  let(:resource) { params[:resource_class].new(mocked_http_client) }
  let(:id) { 'a-id@' }
  let(:encoded_url) { "#{resource.to_url}/#{URI.encode_www_form_component(id)}" }
  let(:request_response) do
    Struct.new(:status, :body) do
      def initialize(status:, body: {})
        super(status, body)
      end
    end
  end

  describe '#find' do
    it 'finds the resource through http_client get method' do
      expect(mocked_http_client).to receive(:get).with(
        encoded_url,
        headers: {},
        params: {}
      ).and_return request_response.new(
        status: 200,
        body: params[:body_response]
      )

      response = resource.find(id: id)

      expect(response.success?).to eq(true)
      expect(response.resource_response).to eq(params[:body_response][resource.to_single_resource])
    end

    context 'with error response' do
      it 'returns success false and sets the error msg' do
        expect(mocked_http_client).to receive(:get).with(
          encoded_url,
          headers: {},
          params: {}
        ).and_return request_response.new(
          status: 400,
          body: params[:error_response]
        )

        response = resource.find(id: id)

        expect(response.success?).to eq(false)
        expect(response.error_response).to eq(params[:error_response]['error'])
      end
    end
  end

  describe '#find!' do
    it 'finds the resource through http_client get method' do
      expect(mocked_http_client).to receive(:get).with(
        encoded_url,
        headers: {},
        params: {}
      ).and_return request_response.new(
        status: 200,
        body: params[:body_response]
      )

      response = resource.find!(id: id)

      expect(response.success?).to eq(true)
      expect(response.resource_response).to eq(params[:body_response][resource.to_single_resource])
    end

    context 'with error response' do
      it 'raises an error' do
        expect(mocked_http_client).to receive(:get).with(
          encoded_url,
          headers: {},
          params: {}
        ).and_return request_response.new(
          status: 400,
          body: params[:error_response]
        )

        expect { resource.find!(id: id) }.to raise_error(Openpix::RubySdk::Resources::RequestError)
      end
    end
  end
end

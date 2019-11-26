require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Metrics' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'metrics' do
        it 'should add the metrics method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :metrics
          expect(nomad_client.metrics).to be_kind_of NomadClient::Api::Metrics
        end
      end

      describe 'Metrics API methods' do
        let(:block_receiver)   { double(:block_receiver) }
        let!(:connection)      { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          let(:prefix_params) { {} }
          let(:block_receiver) { double(:block_receiver, params: prefix_params) }
          context 'with no prefix' do
            it 'should call get on the metrics endpoint with a nil prefix' do
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("metrics")
              expect(prefix_params).to receive(:[]=).with(:format, nil)

              nomad_client.metrics.get
            end
          end
          context 'with a prefix' do
            it 'should call get on the metrics endpoint with a prefix supplied' do
              expect(connection).to receive(:get).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("metrics")
              expect(prefix_params).to receive(:[]=).with(:format, 'prometheus')

              nomad_client.metrics.get(format: 'prometheus')
            end
          end
        end
      end
    end
  end
end

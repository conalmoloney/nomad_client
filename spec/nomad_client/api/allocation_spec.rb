require 'spec_helper'
module NomadClient
  module Api
    RSpec.describe 'Allocation' do
      let!(:nomad_client) { NomadClient::Connection.new('http://nomad.local') }

      describe 'allocation' do
        it 'should add the allocation method to the NomadClient::Connection class' do
          expect(nomad_client).to respond_to :allocation
          expect(nomad_client.allocation).to be_kind_of NomadClient::Api::Allocation
        end
      end

      describe 'Allocation API methods' do
        let(:block_receiver) { double(:block_receiver) }
        let(:allocation_id)  { '203266e5-e0d6-9486-5e05-397ed2b184af' }
        let!(:connection)    { double(:connection) }

        before do
          allow(nomad_client).to receive(:connection).and_return(connection)
        end

        describe '#get' do
          it 'should call get with allocation_id on the allocation_id endpoint' do
            expect(connection).to receive(:get).and_yield(block_receiver)
            expect(block_receiver).to receive(:url).with("allocation/#{allocation_id}")

            nomad_client.allocation.get(allocation_id)
          end
        end

        describe '#restart' do
          context 'task unspecified' do
            it 'should post to client/allocation/:allocation_id/restart' do
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("client/allocation/#{allocation_id}/restart")

              nomad_client.allocation.restart(allocation_id)
            end
          end
          context 'task specified' do
            it 'should post to client/allocation/:allocation_id/restart with a payload' do
              expect(connection).to receive(:post).and_yield(block_receiver)
              expect(block_receiver).to receive(:url).with("client/allocation/#{allocation_id}/restart")
              expect(block_receiver).to receive(:body=).with({ 'Task' => 'foo' })

              nomad_client.allocation.restart(allocation_id, 'foo')
            end
          end
        end
      end
    end
  end
end

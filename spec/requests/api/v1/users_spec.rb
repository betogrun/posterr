# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users/{id}' do
    get 'Retrieve user profile' do
      tags 'User Profile'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { id: 1 }, name: 'id', summary: 'User id'

      after do |example|
        content = example.metadata[:response][:content] || {}
        example_spec = {
          'application/json' => {
            examples: {
              example: {
                value: JSON.parse(response.body, symbolize_names: true)
              }
            }
          }
        }
        example.metadata[:response][:content] = content.deep_merge(example_spec)
      end

      response '200', 'User profile found' do
        before do |example|
          travel_to('2021-03-25 03:00:00 UTC') do
            @user = create(:user, username: 'username')
          end
          submit_request(example.metadata)
        end

        let(:id) { @user.id }

        it 'retrieves the user profile' do
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:id]).to eq(id)
          expect(result[:username]).to eq('username')
          expect(result[:joined_at]).to eq('March 25, 2021')
        end
      end

      response '400', 'Invalid param' do
        before { |example| submit_request(example.metadata) }

        let(:id) { 'invalid' }

        it 'returns a invalid params error message' do
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq('Invalid param')
        end
      end

      response '422', 'User not found' do
        before { |example| submit_request(example.metadata) }

        let(:id) { 999 }

        it 'returns a invalid params error message' do
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:error]).to eq('User not found')
        end
      end
    end
  end
end

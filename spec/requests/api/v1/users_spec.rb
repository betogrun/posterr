# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users/{id}' do
    get 'Retrieve user profile' do
      tags 'User Profile'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { id: 1 }, name: 'id', summary: 'User id'

      response '200', 'User profile found' do
        context 'user profile' do
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
            expect(result[:posts_count]).to eq(0)
          end
        end
      end

      response '400', 'Invalid param' do
        context 'invalid user id' do
          before { |example| submit_request(example.metadata) }

          let(:id) { 'invalid' }

          it 'returns an error message' do
            result = JSON.parse(response.body, symbolize_names: true)

            expect(result[:id]).to include('must be greater than or equal to 1')
          end
        end
      end

      response '422', 'User not found' do
        context 'user not found' do
          before { |example| submit_request(example.metadata) }

          let(:id) { 999 }

          it 'returns an error message' do
            result = JSON.parse(response.body, symbolize_names: true)

            expect(result[:user]).to include('user not found')
          end
        end
      end
    end

    after do |example|
      content = example.metadata[:response][:content] || {}
      example_name = example.metadata[:example_group][:description_args]&.first
      example_spec = {
        'application/json' => {
          examples: {
            "#{example_name}": {
              value: JSON.parse(response.body, symbolize_names: true)
            }
          }
        }
      }
      example.metadata[:response][:content] = content.deep_merge(example_spec)
    end
  end
end

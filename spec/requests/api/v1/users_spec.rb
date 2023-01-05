# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users/{id}' do
    get 'Retrieve user profile' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { id: 1 }, name: 'id', summary: 'User id'

      before { |example| submit_request(example.metadata) }

      response '200', 'User profile found' do
        let(:id) { '1' }

        it 'retrieves the user profile' do
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:id]).to eq(id)
          expect(result[:username]).to eq('username')
          expect(result[:joined_at]).to eq('March 25, 2021')
          expect(result[:posts_count]).to eq(0)
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'swagger_helper'

describe 'Post users API' do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieve the user posts' do
      tags 'User posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      request_body_example value: { user_id: 1 }, name: 'user_id', summary: 'User id'

      response '302', 'Redirect' do
        let(:user_id) { 1 }
        run_test!
      end
    end

    post 'Create a post for the user' do
      tags 'User posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string
      request_body_example value: { user_id: 1 }, name: 'user_id', summary: 'User id'

      response '302', 'Redirect' do
        let(:user_id) { 1 }
        run_test!
      end
    end
  end
end

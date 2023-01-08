# frozen_string_literal: true

require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/posts' do
    get 'Retrieve posts' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      request_body_example value: { page: 1 }, name: 'page', summary: 'Page'
      request_body_example value: { per_page: 10 }, name: 'per_page', summary: 'Per page'

      response '200', 'Posts found' do
        context 'all posts' do
          let!(:user_one) { create(:user, username: 'one') }
          let!(:user_two) { create(:user, username: 'two') }
          let!(:user_three) { create(:user, username: 'three') }
          let!(:post_one) { create(:post, :original, user: user_one, content: 'content one') }
          let!(:post_two) { create(:post, :original, user: user_two, content: 'content two') }
          let!(:repost) { create(:post, :repost, user: user_three, original_post: post_one) }
          let!(:quoted_post) { create(:post, :quoted, user: user_one, original_post: post_two, quote: 'quote two') }

          let(:page) { 1 }
          let(:per_page) { 3 }

          before do |example|
            submit_request(example.metadata)
          end

          it 'retrieves all posts' do
            result_set = JSON.parse(response.body, symbolize_names: true)

            actual_quoted_post = result_set[:posts][0]
            actual_repost = result_set[:posts][1]
            actual_post_two = result_set[:posts][2]

            actual_total = result_set[:meta][:total]
            actual_page = result_set[:meta][:page]
            actual_per_page = result_set[:meta][:per_page]

            expect(actual_quoted_post[:id]).to eq(quoted_post.id)
            expect(actual_quoted_post[:kind]).to eq('quoted')
            expect(actual_quoted_post[:quote]).to eq('quote two')
            expect(actual_quoted_post[:user_id]).to eq(quoted_post.user_id)
            expect(actual_quoted_post[:username]).to eq('one')
            expect(actual_quoted_post[:original_content]).to eq('content two')
            expect(actual_quoted_post[:original_user_id]).to eq(user_two.id)
            expect(actual_quoted_post[:original_username]).to eq('two')

            expect(actual_repost[:id]).to eq(repost.id)
            expect(actual_repost[:kind]).to eq('repost')
            expect(actual_repost[:user_id]).to eq(repost.user_id)
            expect(actual_repost[:username]).to eq('three')
            expect(actual_repost[:original_content]).to eq('content one')
            expect(actual_repost[:original_user_id]).to eq(user_one.id)
            expect(actual_repost[:original_username]).to eq('one')

            expect(actual_post_two[:id]).to eq(post_two.id)
            expect(actual_post_two[:kind]).to eq('original')
            expect(actual_post_two[:content]).to eq('content two')
            expect(actual_post_two[:user_id]).to eq(post_two.user_id)
            expect(actual_post_two[:username]).to eq('two')

            expect(actual_total).to eq(4)
            expect(actual_page).to eq(1)
            expect(actual_per_page).to eq(3)
          end

          after do |example|
            content = example.metadata[:response][:content] || {}
            example_spec = {
              'application/json' => {
                examples: {
                  default: {
                    value: JSON.parse(response.body, symbolize_names: true)
                  }
                }
              }
            }
            example.metadata[:response][:content] = content.deep_merge(example_spec)
          end
        end

        response '400', 'Invalid params' do
          context 'invalid pagination' do
            let(:page) { 0 }
            let(:per_page) { -3 }

            before do |example|
              submit_request(example.metadata)
            end

            it 'return error messages' do
              result_set = JSON.parse(response.body, symbolize_names: true)
              page_error = result_set[:page].first
              per_page_error = result_set[:per_page].first

              expect(page_error).to eq('must be greater than or equal to 1')
              expect(per_page_error).to eq('must be greater than or equal to 1')
            end

            after do |example|
              content = example.metadata[:response][:content] || {}
              example_spec = {
                'application/json' => {
                  examples: {
                    'invalid pagination': {
                      value: JSON.parse(response.body, symbolize_names: true)
                    }
                  }
                }
              }
              example.metadata[:response][:content] = content.deep_merge(example_spec)
            end
          end
        end
      end
    end

    post 'Create post' do
      tags 'Posts'
      consumes 'application/json'
      parameter(
        name: :params,
        in: :body, schema: {
          properties: {
            user_id: { type: :string },
            content: { type: :string },
            kind: { type: :string }
          },
          required: ['user_id']
        }
      )

      response '201', 'Post created' do
        context 'original post' do
          let!(:user) { create(:user, id: params[:user_id]) }
          let(:params) do
            {
              user_id: 99,
              kind: 'original',
              content: 'original content'
            }
          end
          before { |example| submit_request(example.metadata) }

          it 'returns the original post created' do
            result = JSON.parse(response.body, symbolize_names: true)[:post]

            expect(result[:id]).not_to be_nil
            expect(result[:content]).to eq('original content')
            expect(result[:kind]).to eq('original')
          end

          after do |example|
            content = example.metadata[:response][:content] || {}
            example_spec = {
              'application/json' => {
                examples: {
                  'original post': {
                    value: JSON.parse(response.body, symbolize_names: true)
                  }
                }
              }
            }
            example.metadata[:response][:content] = content.deep_merge(example_spec)
          end
        end
      end
    end
  end
end

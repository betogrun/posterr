# frozen_string_literal: true

require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/posts' do
    get 'Retrieve posts' do
      tags 'Posts'
      produces 'application/json'
      # parameter name: :user_id, in: :path, type: :string
      # parameter name: :start_date, in: :path, type: :string
      # parameter name: :end_date, in: :path, type: :string
      # parameter name: :page, in: :path, type: :string
      # parameter name: :per_page, in: :path, type: :string

      response '200', 'Posts found' do
        context 'all posts' do
          let!(:user_one) { create(:user, username: 'one') }
          let!(:user_two) { create(:user, username: 'two') }
          let!(:user_three) { create(:user, username: 'three') }
          let!(:post_one) { create(:post, :original, user: user_one, content: 'content one') }
          let!(:post_two) { create(:post, :original, user: user_two, content: 'content two') }
          let!(:repost) { create(:post, :repost, user: user_three, original_post: post_one) }
          let!(:quoted_post) { create(:post, :quoted, user: user_one, original_post: post_two, quote: 'quote two') }

          before do |example|
            submit_request(example.metadata)
          end

          it 'retrieves all posts' do
            result_set = JSON.parse(response.body, symbolize_names: true)[:posts]
            actual_quoted_post = result_set[0]
            actual_repost = result_set[1]
            actual_post_two = result_set[2]
            actual_post_one = result_set[3]

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

            expect(actual_post_one[:id]).to eq(post_one.id)
            expect(actual_post_one[:kind]).to eq('original')
            expect(actual_post_one[:content]).to eq('content one')
            expect(actual_post_one[:user_id]).to eq(post_one.user_id)
            expect(actual_post_one[:username]).to eq('one')
          end

          after do |example|
            content = example.metadata[:response][:content] || {}
            example_spec = {
              'application/json' => {
                examples: {
                  all_posts: {
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

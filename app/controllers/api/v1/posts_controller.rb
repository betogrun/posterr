# frozen_string_literal: true

module API
  module V1
    class PostsController < ::API::V1::Controller
      def index
        ::Feed::RetrievePosts.call(params: permitted_params)
          .on_success { |result| render_json(result[:posts], serializer: ::Feed::RetrievePosts::PostsSerializer, status: :ok) }
          .on_failure(:invalid_params) { |result| render(json: result[:errors], status: :bad_request) }
      end

      def create
        ::Feed::CreatePosts.call(params: permitted_params)
          .on_success { |result| render_json(result[:post], serializer: ::Feed::CreatePosts::PostSerializer, status: :created) }
          .on_failure(:invalid_params) { |result| render(json: result[:errors], status: :bad_request) }
          .on_failure(:user_not_found) { |result| render(json: result[:error], status: :unprocessable_entity) }
          .on_failure(:original_post_not_found) { |result| render(json: result[:error], status: :unprocessable_entity) }
          .on_failure(:post_quota_exceeded) { |result| render(json: result[:error], status: :unprocessable_entity) }
      end

      private

      def permitted_params
        params
          .permit(:page, :per_page, :user_id, :kind, :content, :original_post_id, :quote)
          .with_defaults(page: 1, per_page: 10)
      end
    end
  end
end

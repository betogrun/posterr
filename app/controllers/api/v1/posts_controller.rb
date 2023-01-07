# frozen_string_literal: true

module API
  module V1
    class PostsController < ::API::V1::Controller
      def index
        ::Feed::RetrievePosts.call(params: ::Feed::Params.new(permitted_params))
          .on_success { |result| render_json(result[:posts], serializer: ::API::V1::PostsSerializer, status: :ok) }
          .on_failure(:invalid_params) { |result| render(json: result[:errors], status: :bad_request) }
      end

      private

      def permitted_params
        params
          .permit(:page, :per_page)
          .with_defaults(page: 1, per_page: 10)
      end
    end
  end
end

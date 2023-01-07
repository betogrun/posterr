# frozen_string_literal: true

module API
  module V1
    class PostsController < ::API::V1::Controller
      def index
        ::Feed::RetrievePosts.call
          .on_success { |result| render_json(result[:posts], serializer: ::API::V1::PostsSerializer, status: :ok) }
      end
    end
  end
end

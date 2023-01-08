# frozen_string_literal: true

module API
  module V1
    module Users
      class PostsController < ::API::V1::Controller
        def index
          redirect_to controller: '/api/v1/posts', action: 'index', params: permitted_params
        end

        def create
          redirect_to controller: '/api/v1/posts', action: 'create', params: permitted_params
        end

        private

        def permitted_params
          params
            .permit(:page, :per_page, :user_id, :kind, :content, :original_post_id, :quote)
            .with_defaults(page: 1, per_page: 5, user_id: params[:user_id])
        end
      end
    end
  end
end

# frozen_string_literal: true

module API
  module V1
    class UsersController < ::API::V1::Controller
      def show
        ::Profile::RetrieveUser.call(params:)
          .on_success { |result| render_json(result[:user], serializer: ::Profile::UserSerializer, status: :ok) }
          .on_failure(:invalid_params) { |result| render(json: result[:errors], status: :bad_request) }
          .on_failure(:user_not_found) { |result| render(json: result[:error], status: :unprocessable_entity) }
      end
    end
  end
end

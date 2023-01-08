# frozen_string_literal: true

module API
  module V1
    class UsersController < ::API::V1::Controller
      def show
        ::Profile::RetrieveUser.call(id: params[:id])
          .on_success { |result| render_json(result[:user], serializer: ::Profile::UserSerializer, status: :ok) }
          .on_failure(:invalid_param) { render(json: { error: 'Invalid param'}, status: :bad_request) }
          .on_failure(:not_found) { render(json: { error: 'User not found'}, status: :unprocessable_entity) }
      end
    end
  end
end

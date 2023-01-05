# frozen_string_literal: true

module API
  module V1
    class Controller < ApplicationController
      private

      def render_json(result, serializer:, status: :ok)
        render(json: serializer.new(result).as_json, status:)
      end
    end
  end
end

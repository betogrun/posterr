# frozen_string_literal: true

module API
  module V1
    class UserSerializer
      include ActiveModel::Serializers::JSON

      def initialize(user)
        @id = user.id
        @username = user.username
        @joined_at = user.joined_at
        @posts_count = user.posts_count
      end

      def attributes
        {
          id:,
          username:,
          joined_at:,
          posts_count:
        }
      end

      private

      attr_reader :id, :username, :joined_at, :posts_count
    end
  end
end

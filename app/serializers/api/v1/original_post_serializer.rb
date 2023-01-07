# frozen_string_literal: true

module API
  module V1
    class OriginalPostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @content = post.content
        @user_id = post.user_id
        @username = post.username
      end

      def attributes = {id:, kind:, content:, user_id:, username:}

      private

      attr_reader :id, :kind, :content, :user_id, :username
    end
  end
end

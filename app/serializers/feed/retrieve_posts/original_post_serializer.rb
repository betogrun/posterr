# frozen_string_literal: true

module Feed
  class RetrievePosts
    class OriginalPostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @content = post.content
        @user_id = post.user_id
        @username = post.username
        @posted_at = post.posted_at
      end

      def attributes = {id:, kind:, content:, user_id:, username:, posted_at:}

      private

      attr_reader :id, :kind, :content, :user_id, :username, :posted_at
    end
  end
end

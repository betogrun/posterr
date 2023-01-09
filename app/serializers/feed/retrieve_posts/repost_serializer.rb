# frozen_string_literal: true

module Feed
  class RetrievePosts
    class RepostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @user_id = post.user_id
        @username = post.username
        @original_post_id = post.original_post_id
        @original_content = post.original_content
        @original_user_id = post.original_user_id
        @original_username = post.original_username
        @posted_at = post.posted_at
      end

      def attributes
        {
          id:,
          kind:,
          user_id:,
          username:,
          original_post_id:,
          original_content:,
          original_user_id:,
          original_username:,
          posted_at:
        }
      end

      private

      attr_reader(
        :id,
        :kind,
        :user_id,
        :username,
        :original_post_id,
        :original_post,
        :original_content,
        :original_user_id,
        :original_username,
        :posted_at
      )
    end
  end
end

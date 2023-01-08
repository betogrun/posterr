# frozen_string_literal: true

module Feed
  class RetrievePosts
    class QuotedPostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @user_id = post.user_id
        @username = post.username
        @quote = post.quote
        @original_post_id = post.original_post_id
        @original_content = post.original_content
        @original_user_id = post.original_user_id
        @original_username = post.original_username
      end

      def attributes
        {
          id:,
          kind:,
          user_id:,
          username:,
          quote:,
          original_post_id:,
          original_content:,
          original_user_id:,
          original_username:
        }
      end

      private

      attr_reader(
        :id,
        :kind,
        :user_id,
        :username,
        :quote,
        :original_post_id,
        :original_post,
        :original_content,
        :original_user_id,
        :original_username
      )
    end
  end
end

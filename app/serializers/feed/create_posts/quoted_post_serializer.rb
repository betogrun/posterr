# frozen_string_literal: true

module Feed
  class CreatePosts
    class QuotedPostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @user_id = post.user_id
        @quote = post.quote
        @original_post_id = post.original_post_id
      end

      def attributes
        {
          id:,
          kind:,
          user_id:,
          quote:,
          original_post_id:
        }
      end

      private

      attr_reader(
        :id,
        :kind,
        :user_id,
        :quote,
        :original_post_id
      )
    end
  end
end

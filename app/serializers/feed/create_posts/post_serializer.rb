# frozen_string_literal: true

module Feed
  class CreatePosts
    class PostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @post = post
      end

      def attributes = { post:}

      private

      def post = serializer.new(@post)

      def serializer
        case @post.kind
        when 'original' then ::Feed::CreatePosts::OriginalPostSerializer
        when 'repost' then ::Feed::CreatePosts::RepostSerializer
        when 'quoted' then ::Feed::CreatePosts::QuotedPostSerializer
        end
      end
    end
  end
end

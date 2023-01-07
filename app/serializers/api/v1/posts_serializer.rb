# frozen_string_literal: true

module API
  module V1
    class PostsSerializer
      include ActiveModel::Serializers::JSON

      def initialize(posts)
        @posts = posts
      end

      def attributes
        { posts: }
      end

      private

      def posts
        @posts.map { |post| serializer_for(post.kind).new(post) }
      end

      def serializer_for(kind)
        case kind
        when 'original' then ::API::V1::OriginalPostSerializer
        when 'repost' then ::API::V1::RepostSerializer
        when 'quoted' then ::API::V1::QuotedPostSerializer
        end
      end
    end
  end
end

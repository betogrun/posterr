# frozen_string_literal: true

module API
  module V1
    class PostsSerializer
      include ActiveModel::Serializers::JSON

      def initialize(posts)
        @posts = posts
        @total = posts.total
        @page = posts.page
        @per_page = posts.per_page
      end

      def attributes = { posts:, meta: }

      private

      def meta = { total:, page:, per_page: }

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

      attr_reader :total, :page, :per_page
    end
  end
end

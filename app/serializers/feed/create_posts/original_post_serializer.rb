# frozen_string_literal: true

module Feed
  class CreatePosts
    class OriginalPostSerializer
      include ActiveModel::Serializers::JSON

      def initialize(post)
        @id = post.id
        @kind = post.kind
        @content = post.content
      end

      def attributes = {id:, kind:, content:}

      private

      attr_reader :id, :kind, :content
    end
  end
end

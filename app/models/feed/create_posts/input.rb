# frozen_string_literal: true

module Feed
  class CreatePosts
    class Input
      include ActiveModel::Validations

      validates :user_id, presence: true
      validates :kind, inclusion: { in: ['original', 'repost', 'quoted'] }
      validates :content, presence: true, length: { maximum: 777 }, if: -> { kind.original? }
      validates :original_post_id, presence: true, unless: -> { kind.original? }
      validates :quote, presence: true, length: { maximum: 777 }, if: -> { kind.quoted? }

      def initialize(params)
        @user_id = params['user_id']
        @kind = params['kind']
        @content = params['content']
        @original_post_id = params['original_post_id']
        @quote = params['quote']
      end

      def self.to_proc = ->(params) { new(params) }

      def user_id = @user_id&.to_i

      def original_post_id = @original_post_id&.to_i

      def kind = @kind&.inquiry

      attr_reader :content, :quote
    end
  end
end

# frozen_string_literal: true

module Feed
  class CreatePosts
    class Input
      include ActiveModel::Validations

      validates :user_id, presence: true
      validates :kind, inclusion: { in: ['original', 'repost', 'quoted'] }
      validates :content, presence: true, length: { maximum: 777 }, if: -> { kind == 'original' }

      def initialize(params)
        @user_id = params['user_id']
        @kind = params['kind']
        @content = params['content']
      end

      def self.to_proc = ->(params) { new(params) }

      def user_id = @user_id&.to_i

      attr_reader :kind, :content
    end
  end
end

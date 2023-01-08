# frozen_string_literal: true

module Feed
  class RetrievePosts
    class Input
      include ActiveModel::Validations

      validates :page, :per_page, numericality: { greater_than_or_equal_to: 1 }
      validates :user_id, numericality: { greater_than_or_equal_to: 1 }, if: -> { user_id.present? }

      def initialize(params)
        @user_id = params['user_id']
        @page = params['page']
        @per_page = params['per_page']
      end

      def self.to_proc = ->(params) { new(params) }

      def user_id = @user_id&.to_i

      def page = @page&.to_i

      def per_page = @per_page&.to_i
    end
  end
end

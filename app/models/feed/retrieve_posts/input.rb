# frozen_string_literal: true

module Feed
  class RetrievePosts
    class Input
      include ActiveModel::Validations

      validates :page, :per_page, numericality: { greater_than_or_equal_to: 1 }

      def initialize(params)
        @page = params['page']
        @per_page = params['per_page']
      end

      def page = @page.to_i

      def per_page = @per_page.to_i
    end
  end
end

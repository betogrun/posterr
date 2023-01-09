# frozen_string_literal: true

module Feed
  class RetrievePosts
    class Input
      include ActiveModel::Validations

      validates :page, :per_page, numericality: { greater_than_or_equal_to: 1 }
      validates :user_id, numericality: { greater_than_or_equal_to: 1 }, if: -> { user_id.present? }
      validates :start_date, presence: true, if: -> { end_date.present? }
      validates :end_date, presence: true, if: -> { start_date.present? }
      validate :valid_date_range

      def initialize(params)
        @user_id = params['user_id']
        @page = params['page']
        @per_page = params['per_page']
        @start_date = params['start_date']
        @end_date = params['end_date']
      end

      def self.to_proc = ->(params) { new(params) }

      def user_id = @user_id&.to_i

      def page = @page&.to_i

      def per_page = @per_page&.to_i

      def start_date
        DateTime.parse(@start_date) if @start_date
      end

      def end_date
        DateTime.parse(@end_date) if @end_date
      end

      def valid_date_range
        return if start_date.blank? && end_date.blank?

        errors.add(:end_date, :invalid, message: 'end date must be greater than start date') if start_date.after?(end_date)
      end
    end
  end
end

# frozen_string_literal: true

module Profile
  class Input
    include ActiveModel::Validations

    validates :id, presence: true, numericality: { greater_than_or_equal_to: 1 }

    def initialize(params)
      @id = params['id']
    end

    def self.to_proc = ->(params) { new(params) }

    def id = @id&.to_i
  end
end

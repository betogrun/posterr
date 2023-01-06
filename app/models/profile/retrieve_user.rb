# frozen_string_literal: true

module Profile
  class RetrieveUser < Micro::Case
    attribute :id, default: proc(&:to_i)
    attribute :repository, default: Repository

    def call!
      return Failure(:invalid_param) unless id.positive?

      record = repository.find_user(id)
      return Failure(:not_found) unless record

      joined_date = ::Profile::JoinedDate.new(record.created_at)

      user = ::Profile::User.new(record.id, record.username, joined_date.value)
      Success(result: {user:})
    end
  end
end

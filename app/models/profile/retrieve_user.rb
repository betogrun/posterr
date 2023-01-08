# frozen_string_literal: true

module Profile
  class RetrieveUser < Micro::Case
    attribute :params, default: proc(&::Profile::Input)
    attribute :repository, default: Repository

    def call!
      return Failure(:invalid_params, result: { errors: params.errors }) unless params.valid?

      user_record = repository.find_user(params.id)
      return fail_with_user_not_found unless user_record

      joined_date = ::Profile::JoinedDate.new(user_record.created_at)

      user = ::Profile::User.new(
        user_record.id,
        user_record.username,
        joined_date.value,
        user_record.posts_count
      )
      Success(result: {user:})
    end

    private

    def fail_with_user_not_found
      error = { user: ['user not found'] }
      Failure(:user_not_found, result: { error: })
    end
  end
end

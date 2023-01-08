# frozen_string_literal: true

module Feed
  class CreatePosts < Micro::Case
    POST_QUOTA = 5

    attribute :params, default: proc(&::Feed::CreatePosts::Input)
    attribute :repository, default: Repository

    def call!
      return Failure(:invalid_params, result: { errors: params.errors }) unless params.valid?

      return fail_with_user_not_found unless repository.user_available?(params.user_id)

      return fail_with_original_post_not_found unless params.kind.original? || original_post_available?

      return fail_with_post_quota_exceeded if repository.post_quota_exceeded?(params.user_id, POST_QUOTA)

      post_record = repository.create_post(params)

      Success(result: { post: post_record })
    end

    private

    def fail_with_user_not_found
      error = { user: ['user not found']  }
      Failure(:user_not_found, result: { error: })
    end

    def original_post_available?
      repository.post_available?(params.original_post_id, 'original')
    end

    def fail_with_original_post_not_found
      error = { original_post: ['original post not found'] }
      Failure(:original_post_not_found, result: { error: })
    end

    def fail_with_post_quota_exceeded
      error = { post: ['post quota exceeded'] }
      Failure(:post_quota_exceeded, result: { error: })
    end
  end
end

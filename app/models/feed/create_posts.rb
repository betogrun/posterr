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

      return fail_with_post_reference_not_allowed unless params.kind.original? || post_reference_allowed?

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
      repository.post_available?(params.original_post_id)
    end

    def fail_with_original_post_not_found
      error = { original_post: ['original post not found'] }
      Failure(:original_post_not_found, result: { error: })
    end

    def post_reference_allowed?
      params.kind != repository.original_post_kind(params.original_post_id)
    end

    def fail_with_post_reference_not_allowed
      error = { original_post: ['can\'t be referenced by a post with the same kind'] }
      Failure(:post_reference_not_allowed, result: { error:})
    end

    def fail_with_post_quota_exceeded
      error = { post: ['post quota exceeded'] }
      Failure(:post_quota_exceeded, result: { error: })
    end
  end
end

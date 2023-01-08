# frozen_string_literal: true

module Feed
  class CreatePosts < Micro::Case
    attribute :params, default: proc(&::Feed::CreatePosts::Input)
    attribute :repository, default: Repository

    def call!
      return Failure(:invalid_params) unless params.valid?

      return Failure(:user_not_found) unless repository.user_available?(params.user_id)

      post_record = repository.create_post(params)

      Success(result: { post: {id: post_record.id, kind: post_record.kind, content: post_record.content } })
    end
  end
end

# frozen_string_literal: true

module Feed
  class RetrievePosts < Micro::Case
    attribute :params
    attribute :repository, default: Repository

    def call!
      return Failure(:invalid_params, result: { errors: params.errors }) unless params.valid?

      repository.find_posts(params) => { collection: collection, total: total }

      posts = Posts.new(collection, total, params.page, params.per_page)

      Success(result: { posts: })
    end
  end
end

# frozen_string_literal: true

module Feed
  class RetrievePosts < Micro::Case
    attribute :params
    attribute :repository, default: Repository

    def call!
      post_records = repository.find_posts

      Success(result: { posts: post_records })
    end
  end
end

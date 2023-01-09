# frozen_string_literal: true

module Feed
  module Repository
    module_function

    def find_posts(params)
      collection = ::Post.combined

      collection = collection.where(user_id: params.user_id) if params.user_id

      if params.start_date && params.end_date
        collection = collection.where(created_at: params.start_date..params.end_date)
      end

      total = collection.count(:all)
      offset = (params.page - 1) * params.per_page

      collection = collection
        .limit(params.per_page)
        .offset(offset)

      { collection:, total: }
    end

    def user_available?(user_id)
      User.exists?(id: user_id)
    end

    def create_post(params)
      ::Post.create(
        user_id: params.user_id,
        content: params.content,
        kind: params.kind,
        original_post_id: params.original_post_id,
        quote: params.quote
      )
    end

    def post_available?(id, kind)
      ::Post.exists?(id:, kind:)
    end

    def post_quota_exceeded?(user_id, post_quota)
      date_rage = Date.current.beginning_of_day..Date.current.end_of_day
      ::Post.where(user_id:, created_at: date_rage).count == post_quota
    end
  end
end

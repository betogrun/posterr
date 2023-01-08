# frozen_string_literal: true

module Feed
  module Repository
    module_function

    def find_posts(params)
      collection = ::Post.combined

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
      ::Post.create(user_id: params.user_id, content: params.content, kind: params.kind)
    end
  end
end

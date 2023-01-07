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
  end
end

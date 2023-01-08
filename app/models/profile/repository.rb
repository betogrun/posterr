# frozen_string_literal: true

module Profile
  module Repository
    module_function

    def find_user(id)
      ::User
        .where(id:)
        .left_joins(:posts)
        .select('users.*', 'COUNT(posts.id) AS posts_count')
        .group('users.id')
        .take
    end
  end
end

# frozen_string_literal: true

class CombinedPostsQuery
  def initialize(relation)
    @relation = relation || Post
  end

  def self.call(...)
    new(...).call
  end

  def call
    @relation
      .joins(
        %(
            LEFT JOIN "posts" AS original_posts ON posts.original_post_id = original_posts.id
            LEFT JOIN "users" ON posts.user_id = users.id
            LEFT JOIN "users" AS original_users ON original_posts.user_id = original_users.id
        )
      )
      .select(
        %(
            posts.id,
            posts.kind,
            posts.content,
            posts.user_id,
            users.username,
            original_users.id as original_user_id,
            original_users.username as original_username,
            posts.original_post_id,
            original_posts.content as original_content,
            posts.quote
          )
      )
      .order('posts.created_at DESC')
  end
end

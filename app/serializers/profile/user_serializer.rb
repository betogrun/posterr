# frozen_string_literal: true

module Profile
  class UserSerializer
    include ActiveModel::Serializers::JSON

    def initialize(user)
      @id = user.id
      @username = user.username
      @joined_at = user.joined_date
      @posts_count = user.posts_count
    end

    def attributes = {id:, username:, joined_at:, posts_count: }

    private

    attr_reader :id, :username, :joined_at, :posts_count
  end
end

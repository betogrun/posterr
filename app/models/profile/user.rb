# frozen_string_literal: true

module Profile
  User = Data.define(:id, :username, :joined_date, :posts_count)
end

# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :original_post, class_name: 'Post', optional: true
end

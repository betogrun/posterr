# frozen_string_literal: true

module Feed
  Posts = Data.define(:collection, :total, :page, :per_page) do
    include Enumerable

    delegate :each, to: :collection
  end
end

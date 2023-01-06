# frozen_string_literal: true

module Profile
  class JoinedDate
    def initialize(date)
      @date = date
    end

    def value
      @date.strftime('%B %d, %Y')
    end
  end
end

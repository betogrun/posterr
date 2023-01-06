# frozen_string_literal: true

module Profile
  module Repository
    module_function

    def find_user(id)
      ::User.find_by(id:)
    end
  end
end

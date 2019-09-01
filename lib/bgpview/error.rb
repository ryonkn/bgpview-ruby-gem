# frozen_string_literal: true

module BGPView
  class Error < StandardError; end
  class InvalidASNumber < Error; end
  class ApiError < Error; end
end

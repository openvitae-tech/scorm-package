# frozen_string_literal: true

module ScormPackage
  class BaseVideo
    ABSTRACT_METHODS = %i[id language video_url].freeze

    def initialize
      raise "Cannot initialize an abstract BaseVideo class" if instance_of?(BaseVideo)

      missing_methods = ABSTRACT_METHODS.reject { |method| respond_to?(method) }
      return if missing_methods.empty?

      raise NotImplementedError, "#{self.class} must implement methods: #{missing_methods.join(", ")}"
    end
  end
end

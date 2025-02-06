# frozen_string_literal: true

module ScormPackage
  class BaseCourseModule
    ABSTRACT_METHODS = %i[title lessons].freeze

    def initialize
      raise "Cannot initialize an abstract BaseCourseModule class" if instance_of?(BaseCourseModule)

      missing_methods = ABSTRACT_METHODS.reject { |method| respond_to?(method) }
      return if missing_methods.empty?

      raise NotImplementedError, "#{self.class} must implement methods: #{missing_methods.join(", ")}"
    end
  end
end

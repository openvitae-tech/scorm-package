# frozen_string_literal: true

module ScormPackage
  class BaseCourse
    ABSTRACT_METHODS = %i[title description course_modules].freeze

    def initialize
      raise "Cannot initialize an abstract BaseCourse class" if instance_of?(BaseCourse)

      missing_methods = ABSTRACT_METHODS.reject { |method| respond_to?(method) }
      return if missing_methods.empty?

      raise NotImplementedError, "#{self.class} must implement methods: #{missing_methods.join(", ")}"
    end
  end
end

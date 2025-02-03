# frozen_string_literal: true

module ScormPackage
  class BaseLesson
    ABSTRACT_METHODS = %i[title videos].freeze

    def initialize
      raise "Cannot initialize an abstract BaseLesson class" if instance_of?(BaseLesson)

      missing_methods = ABSTRACT_METHODS.reject { |method| respond_to?(method) }
      return if missing_methods.empty?

      raise NotImplementedError, "#{self.class} must implement methods: #{missing_methods.join(", ")}"
    end
  end
end

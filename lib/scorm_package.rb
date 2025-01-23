# frozen_string_literal: true

require_relative "scorm_package/version"
require_relative "scorm_package/abstract_course"
require_relative "scorm_package/abstract_course_module"
require_relative "scorm_package/abstract_lesson"
require_relative "scorm_package/packaging/generate"

module ScormPackage
  class Error < StandardError; end
end

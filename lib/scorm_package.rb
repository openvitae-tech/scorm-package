# frozen_string_literal: true

require_relative "scorm_package/version"
require_relative "scorm_package/base_course"
require_relative "scorm_package/base_course_module"
require_relative "scorm_package/base_lesson"
require_relative "scorm_package/packaging/generator"

module ScormPackage
  class Error < StandardError; end
end

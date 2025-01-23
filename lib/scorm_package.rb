# frozen_string_literal: true

require_relative "scorm_package/version"
require_relative "scorm_package/course"
require_relative "scorm_package/course_module"
require_relative "scorm_package/lesson"
require_relative "scorm_package/packaging/generate"

module ScormPackage
  class Error < StandardError; end
end

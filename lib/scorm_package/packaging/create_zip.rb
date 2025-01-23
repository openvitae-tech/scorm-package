# frozen_string_literal: true

require "zip"

module ScormPackage
  module Packaging
    class CreateZip
      attr_reader :manifest, :lessons

      root_path = File.expand_path("..", __dir__)

      SCHEMA_FILES = [
        File.join(root_path, "packaging", "common", "adlcp_rootv1p2.xsd"),
        File.join(root_path, "packaging", "common", "ims_xml.xsd"),
        File.join(root_path, "packaging", "common", "imscp_rootv1p1p2.xsd"),
        File.join(root_path, "packaging", "common", "imsmd_rootv1p2p1.xsd"),
        File.join(root_path, "packaging", "common", "scormfunctions.js")
      ].freeze

      def initialize(manifest, lessons)
        @manifest = manifest
        @lessons = lessons
      end

      def process
        create_zip_package
      end

      private

      def create_zip_package
        Zip::File.open("scorm.zip", Zip::File::CREATE) do |zipfile|
          add_manifest(zipfile)
          add_source_files(zipfile)
          add_lesson_files(zipfile)
        end
      end

      def add_manifest(zipfile)
        zipfile.get_output_stream("imsmanifest.xml") { |f| f.write(manifest) }
      end

      def add_source_files(zipfile)
        SCHEMA_FILES.each do |file|
          filename = File.basename(file)
          zipfile.add(filename, file)
        end
      end

      def add_lesson_files(zipfile)
        lessons.each do |lesson_path, lesson_content|
          zipfile.get_output_stream(lesson_path) { |f| f.write(lesson_content) }
        end
      end
    end
  end
end

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
        buffer = Zip::OutputStream.write_buffer do |zipfile|
          add_manifest(zipfile)
          add_source_files(zipfile)
          add_lesson_files(zipfile)
        end
        buffer.string
      end

      def add_manifest(zipfile)
        zipfile.put_next_entry("imsmanifest.xml")
        zipfile.write(manifest)
      end

      def add_source_files(zipfile)
        SCHEMA_FILES.each do |file|
          filename = File.basename(file)
          zipfile.put_next_entry(filename)
          zipfile.write(File.read(file))
        end
      end

      def add_lesson_files(zipfile)
        lessons.each do |lesson_path, lesson_content|
          zipfile.put_next_entry(lesson_path)
          zipfile.write(lesson_content)
        end
      end
    end
  end
end

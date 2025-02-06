# frozen_string_literal: true

require_relative "create_zip"

module ScormPackage
  module Packaging
    class Generator
      attr_reader :course, :scorm_token

      def initialize(course, scorm_token)
        @course = course
        @scorm_token = scorm_token
      end

      def generate
        manifest = generate_manifest
        lessons_html = generate_lesson_contents
        ScormPackage::Packaging::CreateZip.new(manifest, lessons_html).process
      end

      private

      def generate_manifest
        <<~XML
          <?xml version="1.0" standalone="no" ?>
          <manifest identifier="#{course.title}" version="1"
                    xmlns="http://www.imsproject.org/xsd/imscp_rootv1p1p2"
                    xmlns:adlcp="http://www.adlnet.org/xsd/adlcp_rootv1p2"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.imsproject.org/xsd/imscp_rootv1p1p2 imscp_rootv1p1p2.xsd
                             http://www.imsglobal.org/xsd/imsmd_rootv1p2p1 imsmd_rootv1p2p1.xsd
                             http://www.adlnet.org/xsd/adlcp_rootv1p2 adlcp_rootv1p2.xsd">
            <metadata>
              <schema>ADL SCORM</schema>
              <schemaversion>1.2</schemaversion>
            </metadata>
            <organizations default="default-org">
              <organization identifier="default-org">
                <title>#{course.title}</title>
                #{generate_modules(course.course_modules)}
              </organization>
            </organizations>
            <resources>
              #{generate_resources(course.course_modules)}
              <resource identifier="common_files" type="webcontent" adlcp:scormtype="asset">
                <file href="scormfunctions.js"/>
              </resource>
            </resources>
          </manifest>
        XML
      end

      def generate_modules(modules)
        modules.map.with_index(1) do |mod, mod_index|
          <<~XML
            <item identifier="module-#{mod_index}">
              <title>#{mod.title}</title>
              #{generate_lessons(mod.lessons, mod_index)}
            </item>
          XML
        end.join
      end

      def generate_lessons(lessons, mod_index)
        lessons.map.with_index(1) do |lesson, lesson_index|
          <<~XML
            <item identifier="module-#{mod_index}-lesson-#{lesson_index}" identifierref="resource-module-#{mod_index}-lesson-#{lesson_index}">
              <title>#{lesson.title}</title>
            </item>
          XML
        end.join
      end

      def generate_resources(modules)
        modules.flat_map.with_index(1) do |mod, mod_index|
          mod.lessons.map.with_index(1) do |_, lesson_index|
            <<~XML
              <resource identifier="resource-module-#{mod_index}-lesson-#{lesson_index}" type="webcontent" adlcp:scormtype="sco" href="content/module#{mod_index}/lesson#{lesson_index}.html">
                <file href="content/module#{mod_index}/lesson#{lesson_index}.html" />
                <dependency identifierref="common_files" />
              </resource>
            XML
          end
        end.join
      end

      def generate_lesson_html(lesson)
        <<~HTML
          <!DOCTYPE html>
          <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="../../scormfunctions.js"></script>
            <title>#{lesson.title}</title>
            <style>
              .loader { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); }
              iframe { display: none; width: 560px; height: 315px; border: none; }
            </style>
          </head>
          <body>
            <p>Lesson: #{lesson.title}</p>
            <ul>#{lesson.videos.map do |video|
              "<li>Language: #{video.language}<br>" \
              "<div id=\"loader-#{video.id}\" class=\"loader\">Loading...</div>" \
              "<iframe id=\"custom-iframe-#{video.id}\" data-video-url=\"#{video.video_url}\"></iframe></li>"
            end.join}</ul>
            <script>
              const loadIframe = async (iframe) => {
                const loader = document.getElementById(`loader-${iframe.id.split('-').pop()}`);
                try {
                  loader.style.display = 'block';
                  const response = await fetch(iframe.dataset.videoUrl, {
                    headers: { 'X-Scorm-Token': '#{scorm_token}' }
                  });
                  iframe.srcdoc = await response.text();
                  iframe.style.display = 'block';
                } catch (error) { console.error(error); }
                finally { loader.style.display = 'none'; }
              };
              window.addEventListener('load', () =>
                document.querySelectorAll('iframe[data-video-url]').forEach(loadIframe)
              );
            </script>
          </body>
          </html>
        HTML
      end

      def generate_lesson_contents
        lessons_hash = {}

        course.course_modules.each_with_index do |mod, mod_index|
          mod.lessons.each_with_index do |lesson, lesson_index|
            lesson_path = "content/module#{mod_index + 1}/lesson#{lesson_index + 1}.html"
            lessons_hash[lesson_path] = generate_lesson_html(lesson)
          end
        end
        lessons_hash
      end
    end
  end
end

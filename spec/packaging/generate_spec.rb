# frozen_string_literal: true

RSpec.describe ScormPackage::Packaging::Generate do
  let(:lesson_videos) do
    [
      { id: 1, language: "English", video_url: "https://example.com/video1" },
      { id: 2, language: "French", video_url: "https://example.com/video2" }
    ]
  end

  let(:lessons) do
    [
      double("Lesson", title: "Lesson 1", videos: lesson_videos),
      double("Lesson", title: "Lesson 2", videos: [])
    ]
  end

  let(:modules) do
    [
      double("Module", title: "Module 1", lessons: lessons),
      double("Module", title: "Module 2", lessons: [])
    ]
  end

  let(:course) do
    double("Course", title: "Test Course", course_modules: modules)
  end

  subject { described_class.new(course, "123456789") }

  describe "#generate_manifest" do
    it "generates a valid SCORM manifest XML" do
      manifest = subject.send(:generate_manifest)

      xml_doc = Nokogiri::XML(manifest, &:strict)
      expect(xml_doc.errors).to be_empty
      expect(manifest).to include('<manifest identifier="Test Course"')
    end
  end

  describe "#generate_modules" do
    it "generates the correct module items" do
      modules_xml = subject.send(:generate_modules, modules)

      expect(modules_xml).to include('<item identifier="module-1">')
      expect(modules_xml).to include("<title>Module 1</title>")
    end
  end

  describe "#generate_lessons" do
    it "generates XML for lessons within a module" do
      lessons_xml = subject.send(:generate_lessons, lessons, 1)
      expect(lessons_xml).to include('<item identifier="module-1-lesson-1"')
      expect(lessons_xml).to include("<title>Lesson 1</title>")
    end
  end

  describe "#generate_resources" do
    it "generates XML for resources in modules and lessons" do
      resources_xml = subject.send(:generate_resources, modules)
      expect(resources_xml).to include('<resource identifier="resource-module-1-lesson-1"')
      expect(resources_xml).to include('href="content/module1/lesson1.html"')
    end
  end
end

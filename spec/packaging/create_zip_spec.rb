# frozen_string_literal: true

RSpec.describe ScormPackage::Packaging::CreateZip do
  let(:mock_manifest) { "<manifest>Test Manifest</manifest>" }
  let(:mock_lessons) do
    {
      "lesson1.html" => "<html>Lesson 1 Content</html>",
      "lesson2.html" => "<html>Lesson 2 Content</html>"
    }
  end

  describe "#create_zip_package" do
    it "creates a zip file" do
      zip_creator = described_class.new(mock_manifest, mock_lessons)
      expect(Zip::File).to receive(:open).with("scorm.zip", Zip::File::CREATE).and_call_original
      zip_creator.process

      expect(File.exist?("scorm.zip")).to be true
      File.delete("scorm.zip") if File.exist?("scorm.zip")
    end
  end
end

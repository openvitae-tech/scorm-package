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
      zip_creator = described_class.new(mock_manifest, mock_lessons).process

      Zip::File.open_buffer(zip_creator) do |zip_file|
        expect(zip_file.find_entry("imsmanifest.xml")).not_to be_nil

        manifest_entry = zip_file.read("imsmanifest.xml")
        expect(manifest_entry).to eq(mock_manifest)
      end
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::BaseVideo do
  let(:valid_class) do
    Class.new(ScormPackage::BaseVideo) do
      def id
        "Sample Title"
      end

      def language
        "English"
      end

      def video_url
        "http://example.com/video.mp4"
      end
    end
  end

  let(:invalid_class) do
    Class.new(ScormPackage::BaseVideo) do
    end
  end

  describe "#initialize" do
    it "raises an error when invoked directly" do
      expect do
        ScormPackage::BaseVideo.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract BaseVideo class")
    end
  end

  describe "abstract methods" do
    it "does not raise an error for a valid class" do
      expect { valid_class.new }.not_to raise_error
    end

    it "raises an error if required methods are not implemented" do
      expect do
        invalid_class.new
      end.to raise_error(NotImplementedError, /must implement methods: id, language, video_url/)
    end
  end
end

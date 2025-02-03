# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::BaseCourseModule do
  let(:valid_class) do
    Class.new(ScormPackage::BaseCourseModule) do
      def title
        "Sample Title"
      end

      def lessons
        []
      end
    end
  end

  let(:invalid_class) do
    Class.new(ScormPackage::BaseCourseModule) do
    end
  end

  describe "#initialize" do
    it "raises an error when invoked directly" do
      expect do
        ScormPackage::BaseCourseModule.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract BaseCourseModule class")
    end
  end

  describe "abstract methods" do
    it "does not raise an error for a valid class" do
      expect { valid_class.new }.not_to raise_error
    end

    it "raises an error if required methods are not implemented" do
      expect do
        invalid_class.new
      end.to raise_error(NotImplementedError, /must implement methods: title, lessons/)
    end
  end
end

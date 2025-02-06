# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::BaseCourse do
  let(:valid_class) do
    Class.new(ScormPackage::BaseCourse) do
      def title
        "Sample Title"
      end

      def description
        "Sample Description"
      end

      def course_modules
        []
      end
    end
  end

  let(:invalid_class) do
    Class.new(ScormPackage::BaseCourse) do
      def title
        "Course Title"
      end
    end
  end

  describe "#initialize" do
    it "raises an error when invoked directly" do
      expect do
        ScormPackage::BaseCourse.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract BaseCourse class")
    end
  end

  describe "abstract methods" do
    it "does not raise an error for a valid class" do
      expect { valid_class.new }.not_to raise_error
    end

    it "raises an error if required methods are not implemented" do
      expect do
        invalid_class.new
      end.to raise_error(NotImplementedError, /must implement methods: description, course_modules/)
    end
  end
end

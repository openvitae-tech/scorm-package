# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::AbstractCourse do
  describe "#initialize" do
    it "raises an error when attempting to instantiate the abstract class" do
      expect do
        ScormPackage::AbstractCourse.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract Course class")
    end
  end

  describe "abstract methods" do
    let(:abstract_course) { ScormPackage::AbstractCourse.allocate }

    it "raises NotImplementedError when #title is called" do
      expect do
        abstract_course.title
      end.to raise_error(NotImplementedError,
                         "#{abstract_course.class} must implement abstract method 'title'")
    end

    it "raises NotImplementedError when #description is called" do
      expect do
        abstract_course.description
      end.to raise_error(NotImplementedError,
                         "#{abstract_course.class} must implement abstract method 'description'")
    end

    it "raises NotImplementedError when #course_modules is called" do
      expect do
        abstract_course.course_modules
      end.to raise_error(NotImplementedError,
                         "#{abstract_course.class} must implement abstract method 'course_modules'")
    end
  end
end

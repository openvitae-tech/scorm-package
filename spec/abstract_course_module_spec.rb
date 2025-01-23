# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::AbstractCourseModule do
  describe "#initialize" do
    it "raises an error when attempting to instantiate the abstract class" do
      expect do
        ScormPackage::AbstractCourseModule.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract CourseModule class")
    end
  end

  describe "abstract methods" do
    let(:abstract_course_module) { ScormPackage::AbstractCourseModule.allocate }

    it "raises NotImplementedError when #title is called" do
      expect do
        abstract_course_module.title
      end.to raise_error(NotImplementedError,
                         "#{abstract_course_module.class} must implement abstract method 'title'")
    end

    it "raises NotImplementedError when #lessons is called" do
      expect do
        abstract_course_module.lessons
      end.to raise_error(NotImplementedError,
                         "#{abstract_course_module.class} must implement abstract method 'lessons'")
    end
  end
end

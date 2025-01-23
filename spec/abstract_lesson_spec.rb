# frozen_string_literal: true

require "spec_helper"

RSpec.describe ScormPackage::AbstractLesson do
  describe "#initialize" do
    it "raises an error when attempting to instantiate the abstract class" do
      expect do
        ScormPackage::AbstractLesson.new
      end.to raise_error(RuntimeError, "Cannot initialize an abstract Lesson class")
    end
  end

  describe "abstract methods" do
    let(:abstract_lesson) { ScormPackage::AbstractLesson.allocate }

    it "raises NotImplementedError when #title is called" do
      expect do
        abstract_lesson.title
      end.to raise_error(NotImplementedError,
                         "#{abstract_lesson.class} must implement abstract method 'title'")
    end

    it "raises NotImplementedError when #videos is called" do
      expect do
        abstract_lesson.videos
      end.to raise_error(NotImplementedError,
                         "#{abstract_lesson.class} must implement abstract method 'videos'")
    end
  end
end

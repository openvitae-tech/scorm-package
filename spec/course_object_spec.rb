# frozen_string_literal: true

require "spec_helper"

class Course < ScormPackage::BaseCourse
  def title
    "Test course"
  end

  def description
    "This is a sample course"
  end

  def course_modules
    2.times.map do
      CourseModule.new
    end
  end
end

class CourseModule < ScormPackage::BaseCourseModule
  def title
    "Test course module"
  end

  def lessons
    2.times.map do
      Lesson.new
    end
  end
end

class Lesson < ScormPackage::BaseLesson
  def title
    "Test lesson"
  end

  def videos
    2.times.map do
      Video.new
    end
  end
end

class Video < ScormPackage::BaseVideo
  def id
    "1"
  end

  def language
    "english"
  end

  def video_url
    "www.example.com"
  end
end

RSpec.describe "Course" do
  describe "#initialize course" do
    it "returns a course object" do
      course_object = Course.new

      expect(course_object.title).to eq("Test course")
      expect(course_object.course_modules.count).to eq(2)
      expect(course_object.course_modules.first.lessons.count).to eq(2)
    end
  end
end

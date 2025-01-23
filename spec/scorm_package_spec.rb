# frozen_string_literal: true

RSpec.describe ScormPackage do
  it "has a version number" do
    expect(ScormPackage::VERSION).not_to be nil
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Github, type: :model do
  describe ".detect_repo_name" do
    {
      [nil] => nil,
      [nil, ""] => nil,
      [nil, "", " "] => nil,
      [nil, "", "wat"] => nil,
      ["fakegithub.com/rails/rails"] => nil,
      ["http://github.com/{github_username}/{project_name}"] => nil,
      ["http://github.com/rails/rails"] => "rails/rails",
      ["foobar", "http://github.com/rails/rails"] => "rails/rails",
    }.each do |args, expected_name|
      it "is #{expected_name.inspect} when given #{args.inspect}" do
        expect(Github.detect_repo_name(*args)).to be == expected_name
      end
    end
  end

  describe ".normalize_path" do
    {
      nil => nil,
      "" => nil,
      " " => nil,
      "foo/bar" => "foo/bar",
      " foo/bar " => "foo/bar",
      "Foo/bar" => "foo/bar",
    }.each do |path, expected_normalized|
      it "is #{expected_normalized.inspect} when given #{path.inspect}" do
        expect(Github.normalize_path(path)).to be == expected_normalized
      end
    end
  end
end

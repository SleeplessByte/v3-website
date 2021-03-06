require 'test_helper'

class Git::TrackTest < ActiveSupport::TestCase
  test "Retrieves test_regexp" do
    skip # TODO: Renable when not in monorepo
    track = Git::Track.new(TestHelpers.git_repo_url("track-with-exercises"), :ruby)
    assert_equal(/test/, track.test_regexp)
  end

  test "Has correct default test_regexp" do
    skip # TODO: Renable when not in monorepo
    track = Git::Track.new(TestHelpers.git_repo_url("track-naked"), :ruby)
    assert_equal(/[tT]est/, track.test_regexp)
  end

  test "Retrieves ignore_regexp" do
    skip # TODO: Renable when not in monorepo
    track = Git::Track.new(TestHelpers.git_repo_url("track-with-exercises"), :ruby)
    assert_equal(/[iI]gno/, track.ignore_regexp)
  end

  test "Has correct default ignore_regexp" do
    skip # TODO: Renable when not in monorepo
    track = Git::Track.new(TestHelpers.git_repo_url("track-naked"), :ruby)
    assert_equal(/[iI]gnore/, track.ignore_regexp)
  end
end

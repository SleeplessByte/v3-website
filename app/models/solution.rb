class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_one :track, through: :exercise
  has_many :iterations, dependent: :destroy

  has_many :mentor_requests, class_name: "Solution::MentorRequest", dependent: :destroy
  has_many :mentor_discussions, class_name: "Solution::MentorDiscussion", dependent: :destroy

  before_create do
    # Search engines derive meaning by using hyphens
    # as word-boundaries in URLs. Since we use the
    # solution UUID for URLs, we're removing the hyphen
    # to remove any spurious, accidental, and arbitrary
    # meaning.
    self.uuid = SecureRandom.compact_uuid unless self.uuid
    self.public_uuid = SecureRandom.compact_uuid unless self.public_uuid
    self.mentor_uuid = SecureRandom.compact_uuid unless self.mentor_uuid
    self.git_slug = exercise.slug
    self.git_sha = track.git_head_sha
  end

  def downloaded?
    !!downloaded_at
  end

  # TODO: - Use an actual serializer
  def serialized_iterations
    iterations.map do |i|
      {
        id: i.id,
        testsStatus: i.tests_status
      }
    end
  end

  def anonymised_user_handle
    "anonymous-#{mentor_uuid}"
  end

  def update_git_info!
    update!(
      git_slug: exercise.slug,
      git_sha: track.git_head_sha
    )
  end
end

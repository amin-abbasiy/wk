require "test_helper"

class JobApplicationTest < ActiveSupport::TestCase
  self.fixture_table_names = []

  test "status chart includes every status in enum order with scoped counts" do
    user = User.create!(email: "chart-owner@example.com", password: "chart-password-123")
    other_user = User.create!(email: "chart-other@example.com", password: "chart-password-123")
    2.times { user.job_applications.create!(status: :pending) }
    user.job_applications.create!(status: :hired)
    other_user.job_applications.create!(status: :pending)
    other_user.job_applications.create!(status: :offered)

    data = user.job_applications.status_chart_data

    assert_equal JobApplication.statuses.keys.map(&:humanize), data.map(&:first)
    assert_equal 2, data.to_h.fetch("Pending")
    assert_equal 1, data.to_h.fetch("Hired")
    assert_equal 0, data.to_h.fetch("Offered")
    assert_equal 3, data.sum(&:last)
  end

  test "status chart preserves zero counts for an empty relation" do
    data = JobApplication.none.status_chart_data

    assert_equal JobApplication.statuses.size, data.size
    assert data.all? { |_, count| count.zero? }
  end

  test "every status has a unique chart color" do
    colors = JobApplication::STATUS_CHART_COLORS

    assert_equal JobApplication.statuses.keys.map(&:to_sym), colors.keys
    assert_equal colors.size, colors.values.uniq.size
    assert colors.values.all? { |color| color.match?(/\A#[0-9A-F]{6}\z/) }
  end
end

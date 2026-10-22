# These template-only tests do not need database fixtures.
ENV["RAILS_ENV"] ||= "test"
require_relative "../../config/environment"
require "active_support/testing/autorun"
require "action_view/test_case"

class SharedPresentationTest < ActionView::TestCase
  test "form errors are omitted when there are none" do
    record = Struct.new(:errors).new([])

    render "layouts/shared/form_errors", record: record, resource_name: "topic"

    assert_select ".alert", count: 0
  end

  test "form errors keep their messages and escape their content" do
    errors = [Struct.new(:full_message).new("Title <script>example</script> can't be blank")]
    record = Struct.new(:errors).new(errors)

    render "layouts/shared/form_errors", record: record, resource_name: "topic"

    assert_select ".alert-danger[role='alert'] h2", text: "1 error prohibited this topic from being saved:"
    assert_select ".alert-danger li", text: errors.first.full_message
    assert_select "script", count: 0
  end

  test "form pages wrap their content in a responsive column" do
    render layout: "layouts/shared/form_page" do
      tag.p "Existing form content"
    end

    assert_select ".row.justify-content-center > .col-12.col-lg-8 p", text: "Existing form content"
  end

  test "task tables wrap the existing row and label every column" do
    task = Struct.new(:weekly_plan_id, :name, :interval, :start_time, :end_time, :duration, :status, :feelings)
      .new(1, "Practice", 30, "09:00", "10:00", 60, 0, "Ready")

    render layout: "tasks/table" do
      view.render "tasks/task", task: task
    end

    assert_select ".table-responsive > table" do
      assert_select "thead th[scope='col']", count: 8
      assert_select "tbody > tr", count: 1
      assert_select "tbody > tr > th[scope='row']", text: "1"
      assert_select "tbody > tr > td", count: 7
      assert_select "td", text: "Practice"
      assert_select "td", text: "Ready"
    end
  end
end

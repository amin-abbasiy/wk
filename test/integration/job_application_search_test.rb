require "test_helper"

class JobApplicationSearchTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  setup do
    user = User.first || User.create!(email: "search@example.com", password: "search-password-123")
    user.job_applications.create!(company_name: "Microsoft", status: :pending)
    user.job_applications.create!(company_name: "Micro Labs", status: :hired)
    user.job_applications.create!(company_name: "Other Company", position_title: "Microsoft developer", status: :pending)
  end

  test "guests can search company names using case insensitive partial matches" do
    get job_applications_path, params: { query: "  MICRO  " }

    assert_response :success
    assert_select "form[role='search'] input[name='query'][value='MICRO']"
    assert_select ".card-body p", text: /Microsoft/, count: 1
    assert_select ".card-body p", text: /Micro Labs/, count: 1
    assert_select ".card-body p", text: /Other Company/, count: 0
  end

  test "search works together with the status filter" do
    get job_applications_path, params: { query: "micro", filter_status: "hired" }

    assert_response :success
    assert_select ".card-body p", text: /Micro Labs/, count: 1
    assert_select ".card-body p", text: /Microsoft/, count: 0
  end

  test "search treats SQL wildcard characters literally" do
    get job_applications_path, params: { query: "%_" }

    assert_response :success
    assert_select "p", text: "No applications match this company name."
  end

  test "blank search keeps the application list" do
    get job_applications_path, params: { query: " " }

    assert_response :success
    assert_select ".card-body p", text: /Other Company/, count: 1
  end
end

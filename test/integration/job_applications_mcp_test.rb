require "test_helper"

class JobApplicationsMcpTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  setup do
    host! "localhost"
    user = User.create!(email: "mcp-test@example.com", password: "mcp-test-password-123")
    @application = user.job_applications.create!(
      company_name: "MCP Acme",
      position_title: "Senior Backend Engineer",
      status: :tech_in_progress,
      job_description: "Build Ruby services.",
      feedback: "Technical interview scheduled."
    )
  end

  teardown do
    @application.resume.purge if @application.resume.attached?
    @application.cover_letter.purge if @application.cover_letter.attached?
  end

  test "initializes over the mounted Rails endpoint" do
    result = rpc("initialize", {
      protocolVersion: "2025-11-25",
      capabilities: {},
      clientInfo: { name: "job-applications-test", version: "1.0" }
    }).fetch("result")

    assert_equal "2025-11-25", result.fetch("protocolVersion")
    assert_equal "job_applications", result.fetch("serverInfo").fetch("name")
    assert result.fetch("capabilities").key?("tools")
    assert_nil response.headers["Mcp-Session-Id"]
  end

  test "discovers the two read-only tools without signing in" do
    tools = rpc("tools/list").fetch("result").fetch("tools")

    assert_equal %w[get_job_application search_job_applications], tools.map { |tool| tool.fetch("name") }.sort
    assert tools.all? { |tool| tool.fetch("annotations").fetch("readOnlyHint") }
  end

  test "lists applications when no query is supplied" do
    data = call_tool("search_job_applications").fetch("structuredContent")

    assert_equal JobApplication.count, data.fetch("total")
    assert_includes data.fetch("applications").map { |application| application.fetch("id") }, @application.id
  end

  test "searches company names and position titles ignoring case and surrounding spaces" do
    ["  mcp ACME  ", "  senior BACKEND  "].each do |query|
      data = call_tool("search_job_applications", query: query).fetch("structuredContent")

      assert_equal [@application.id], data.fetch("applications").map { |application| application.fetch("id") }
    end
  end

  test "combines search and status filters" do
    @application.user.job_applications.create!(company_name: "MCP Acme Research", status: :pending)
    data = call_tool("search_job_applications", query: "MCP Acme", status: "tech_in_progress").fetch("structuredContent")

    assert_equal 1, data.fetch("total")
    assert_equal @application.id, data.fetch("applications").first.fetch("id")
  end

  test "treats SQL wildcard characters literally" do
    literal = @application.user.job_applications.create!(company_name: "MCP 100%_Company", status: :pending)
    data = call_tool("search_job_applications", query: "%_").fetch("structuredContent")

    assert_equal [literal.id], data.fetch("applications").map { |application| application.fetch("id") }
  end

  test "paginates in a stable newest-first order" do
    applications = 3.times.map do
      @application.user.job_applications.create!(
        company_name: "MCP Pagination",
        status: :pending,
        created_at: Time.utc(2026, 1, 1)
      )
    end
    data = call_tool("search_job_applications", query: "MCP Pagination", limit: 1, offset: 1).fetch("structuredContent")

    assert_equal 3, data.fetch("total")
    assert_equal 1, data.fetch("limit")
    assert_equal 1, data.fetch("offset")
    assert_equal [applications[1].id], data.fetch("applications").map { |application| application.fetch("id") }
  end

  test "returns all saved fields and both original files in one response" do
    resume = "%PDF-1.4\nResume bytes\x00\xFF".b
    cover_letter = "PK\x03\x04Cover letter bytes\x00\xFE".b
    @application.resume.attach(
      io: StringIO.new(resume), filename: "My résumé.pdf", content_type: "application/pdf", identify: false
    )
    @application.cover_letter.attach(
      io: StringIO.new(cover_letter), filename: "cover-letter.docx",
      content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", identify: false
    )

    result = call_tool("get_job_application", id: @application.id)
    data = result.fetch("structuredContent")
    resources = result.fetch("content").select { |content| content.fetch("type") == "resource" }

    assert_equal false, result.fetch("isError")
    assert_equal @application.reload.as_json, data.except("attachments")
    assert_equal data, JSON.parse(result.fetch("content").first.fetch("text"))
    assert_equal %w[resume cover_letter], data.fetch("attachments").map { |attachment| attachment.fetch("name") }
    assert_equal ["My résumé.pdf", "cover-letter.docx"], data.fetch("attachments").map { |attachment| attachment.fetch("filename") }
    assert_equal [resume.bytesize, cover_letter.bytesize], data.fetch("attachments").map { |attachment| attachment.fetch("byte_size") }
    assert_equal [resume, cover_letter], resources.map { |content| Base64.strict_decode64(content.fetch("resource").fetch("blob")) }
    assert_equal data.fetch("attachments").map { |attachment| attachment.fetch("uri") }, resources.map { |content| content.fetch("resource").fetch("uri") }
    assert_equal data.fetch("attachments").map { |attachment| attachment.fetch("content_type") }, resources.map { |content| content.fetch("resource").fetch("mimeType") }
    assert_includes resources.first.fetch("resource").fetch("uri"), "My%20r%C3%A9sum%C3%A9.pdf"
  end

  test "returns applications that have no attachments" do
    result = call_tool("get_job_application", id: @application.id)

    assert_equal false, result.fetch("isError")
    assert_empty result.fetch("structuredContent").fetch("attachments")
    assert_equal ["text"], result.fetch("content").map { |content| content.fetch("type") }
  end

  test "reports a missing application as a tool error" do
    id = JobApplication.maximum(:id) + 1
    result = call_tool("get_job_application", id: id)

    assert_equal true, result.fetch("isError")
    assert_equal "Job application #{id} not found.", result.fetch("content").first.fetch("text")
  end

  test "reports a missing stored file instead of silently omitting it" do
    @application.resume.attach(io: StringIO.new("Resume"), filename: "resume.txt", content_type: "text/plain")
    blob = @application.resume.blob
    blob.service.delete(blob.key)

    result = call_tool("get_job_application", id: @application.id)

    assert_equal true, result.fetch("isError")
    assert_match "missing from storage", result.fetch("content").first.fetch("text")
  end

  test "rejects invalid status and pagination arguments" do
    [{ status: "not-a-status" }, { limit: 0 }, { limit: 101 }, { offset: -1 }].each do |arguments|
      result = call_tool("search_job_applications", arguments)

      assert_equal true, result.fetch("isError")
    end
  end

  private

  def call_tool(name, arguments = {})
    rpc("tools/call", name: name, arguments: arguments).fetch("result")
  end

  def rpc(method, params = {})
    post "/mcp", params: { jsonrpc: "2.0", id: 1, method: method, params: params }, as: :json,
                 headers: { "Accept" => "application/json, text/event-stream", "MCP-Protocol-Version" => "2025-11-25" }
    assert_response :success
    JSON.parse(response.body)
  end
end

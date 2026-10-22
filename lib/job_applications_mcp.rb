require "base64"

module JobApplicationsMcp
  def self.app
    server = MCP::Server.new(
      name: "job_applications",
      instructions: "Search or list job applications to find their IDs, then use get_job_application " \
                    "for all saved details and original resume and cover-letter files in one response."
    )

    server.define_tool(
      name: "search_job_applications",
      description: "Search company names and position titles using case-insensitive partial matches. " \
                   "Omit query to list applications. Returns summaries and IDs for get_job_application.",
      input_schema: {
        properties: {
          query: { type: "string" },
          status: { type: "string", enum: JobApplication.statuses.keys },
          limit: { type: "integer", minimum: 1, maximum: 100, default: 20 },
          offset: { type: "integer", minimum: 0, default: 0 }
        },
        additionalProperties: false
      },
      annotations: { read_only_hint: true }
    ) do |query: "", status: nil, limit: 20, offset: 0|
      applications = JobApplication.all
      query = query.strip
      if query.present?
        applications = applications.where(
          "company_name ILIKE :query OR position_title ILIKE :query",
          query: "%#{JobApplication.sanitize_sql_like(query)}%"
        )
      end
      applications = applications.where(status: status) if status

      data = {
        total: applications.count,
        limit: limit,
        offset: offset,
        applications: applications.order(created_at: :desc, id: :desc).limit(limit).offset(offset).as_json(
          only: %i[id company_name position_title status created_at updated_at]
        )
      }
      MCP::Tool::Response.new([{ type: "text", text: data.to_json }], structured_content: data)
    end

    server.define_tool(
      name: "get_job_application",
      description: "Get every saved field of a job application and its original resume and cover-letter files. " \
                   "Files are embedded as base64 binary resources in this response; no separate download is needed.",
      input_schema: {
        properties: { id: { type: "integer", minimum: 1 } },
        required: ["id"],
        additionalProperties: false
      },
      annotations: { read_only_hint: true }
    ) do |id:|
      application = JobApplication.with_attached_resume.with_attached_cover_letter.find(id)
      attachments = []
      files = []

      %w[resume cover_letter].each do |name|
        attachment = application.public_send(name)
        next unless attachment.attached?

        filename = attachment.filename.to_s
        content_type = attachment.content_type.presence || "application/octet-stream"
        uri = "job-applications://#{id}/#{name}/#{ERB::Util.url_encode(filename)}"
        attachments << {
          name: name,
          filename: filename,
          content_type: content_type,
          byte_size: attachment.byte_size,
          uri: uri
        }
        files << {
          type: "resource",
          resource: {
            uri: uri,
            mimeType: content_type,
            blob: Base64.strict_encode64(attachment.download)
          }
        }
      end

      data = application.as_json.merge("attachments" => attachments)
      MCP::Tool::Response.new(
        [{ type: "text", text: data.to_json }, *files],
        structured_content: data
      )
    rescue ActiveRecord::RecordNotFound
      MCP::Tool::Response.new([{ type: "text", text: "Job application #{id} not found." }], error: true)
    rescue ActiveStorage::FileNotFoundError
      MCP::Tool::Response.new(
        [{ type: "text", text: "An attachment for job application #{id} is missing from storage." }],
        error: true
      )
    end

    MCP::Server::Transports::StreamableHTTPTransport.new(
      server,
      stateless: true,
      enable_json_response: true
    )
  end
end

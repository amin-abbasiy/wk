# README1

## Job applications MCP

Start Rails normally with `bundle exec rails server`. The MCP server runs inside
Rails at `http://localhost:3000/mcp` using Streamable HTTP. No login, token, or
separate process is needed.

Available tools:

- `search_job_applications`: optional `query` (company or position, case-insensitive),
  `status`, `limit` (default 20, maximum 100), and `offset`. Omit `query` to list
  applications. Results contain summaries, IDs, and the total number of matches.
- `get_job_application`: required integer `id`. Returns every saved application
  field and the original resume and cover-letter files together in one response.
  Each attached file is an embedded MCP resource with its MIME type and base64
  `blob`; attachment metadata includes the filename, byte size, and matching URI.
  No additional file-fetching call is required.

Check tool discovery against your running Rails server:

```sh
curl http://localhost:3000/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H 'MCP-Protocol-Version: 2025-11-25' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

## Soft Skills

### Resume and Cover Letter

### Job Application 

### LinkedIn

### Mock Interview and Communication


## Hard Skills

### System Design

### Code Skills

### Code Design Patters

### Data Structures

### Algorithms

### Web Knowledge


## Recovery Skills

Do not kill yourself, study still and reasonable time, there is no other way to learn and remember, do not make yourself resent this, Study and learn and Have Fun daily basis and reward
Yourself for it

### Board Games

### Anime

### Movies

### Right Attitude

### You can be best



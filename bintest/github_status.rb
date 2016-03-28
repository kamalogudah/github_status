require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/github_status")

assert('hello') do
  output, status = Open3.capture2(BIN_PATH)

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "Hello World"
end

assert('version') do
  output, status = Open3.capture2(BIN_PATH, "--version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "github_status version 0.0.1"
end

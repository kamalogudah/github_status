require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/github_status")

assert('It tells you it\'s not a Github repo') do
  output, status = Open3.capture2e(BIN_PATH)

  assert_false status.success?, "Process did not exit cleanly"
  assert_include output, "This is not a GitHub repo"
end

assert('It gives you the version') do
  output, status = Open3.capture2(BIN_PATH, "--version")

  assert_true status.success?, "Process did not exit cleanly"
  assert_include output, "github_status version 0.0.1"
end

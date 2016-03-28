module GithubStatus
  class CLI
    def initialize(argv, output_io = $stdout, error_io = $stderr)
      @options = setup_options
      @opts = @options.parse(argv)
      @output_io = output_io
      @error_io  = error_io
    end

    def run
      if @options.option(:version)
        Version.new(@output_io).run
      elsif @options.option(:help)
        Help.new(@output_io).run
      else
        remote_origin_url = `git config --get remote.origin.url`

        exit_on_error "This is not a GitHub repo" unless remote_origin_url[0..13] == "git@github.com"

        repo_name = remote_origin_url[15..-6]

        refs_head_name = `git symbolic-ref HEAD`

        exit_on_error "The HEAD is detached" unless refs_head_name[0..10] == "refs/heads/"

        branch_name = refs_head_name[11..-1]

        api = API.new("api.github.com", "", {"Accept" => "application/json", "User-Agent" => "github_status CLI"})

        pull_request_url = api.url(
          {repos: repo_name, pulls: nil},
          {head: branch_name}
        )

        json_response = api.get(pull_request_url)

        exit_on_error "No PullRequest found" if json_response.empty?

        sha_head = json_response.first["head"]["sha"]

        status_url = api.url(
          {repos: repo_name, commits: sha_head, status: nil}
        )

        json_response = api.get(status_url)

        @output_io.puts json_response["state"]
      end
    end

    private
    def setup_options
      options = Options.new
      options.add(Option.new("branch", "b", true))
      options.add(Option.new("version", "v"))
      options.add(Option.new("help", "h"))

      options
    end

    def exit_on_error(message, code = 1)
      @error_io.puts message
      exit code
    end
  end
end

module GithubStatus
  class Help
    def initialize(output_io)
      @output_io = output_io
    end

    def run
      @output_io.puts "github_status [switches] [arguments]"
      @output_io.puts "github_status -h, --help               : show this message"
      @output_io.puts "github_status -v, --version            : print github_status version"
    end
  end
end

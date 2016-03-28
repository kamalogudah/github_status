require_relative 'mrblib/github_status/version'

spec = MRuby::Gem::Specification.new('github_status') do |spec|
  spec.bins    = ['github_status']
  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-exit', :core => 'mruby-exit'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-getopts', :mgem => 'mruby-getopts'
  spec.add_dependency 'mruby-polarssl', :mgem => 'mruby-polarssl'
  spec.add_dependency 'mruby-web_api', :github => 'toch/mruby-web_api'
end

spec.license = 'MIT'
spec.author  = 'Christophe Philemotte'
spec.summary = 'A client to retrieve the github status of a given branch'
spec.version = GithubStatus::Version::VERSION

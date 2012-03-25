require 'rubygems' unless defined?(Gem)
require 'rubygems/specification'
require 'rake/gempackagetask'
require 'rake/testtask'

def gemspec
  @gemspec ||= begin
    file = File.expand_path("elasticsearch-node.gemspec")
    ::Gem::Specification.load(file)
  end
end

desc "Ensures the presence of elasticsearch binaries"
task :elasticsearch do
  unless File.exists?("elasticsearch")
    ENV["ES_VERSION"] = "0.19.1"
    `sh es_fetch.sh`
  end
end

desc "Validates the gemspec"
task :gemspec do
  gemspec.validate
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

task :package => :gemspec
task :package => :elasticsearch

Rake::TestTask.new(:test) do |test|
  test.libs << "test"
  test.pattern = 'test/**/*_test.rb'

  test.verbose = true
end

task :default => :test
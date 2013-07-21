require 'rubygems' unless defined?(Gem)
require 'rubygems/specification'
require 'rubygems/package_task'
require 'rake/testtask'

def gemspec
  @gemspec ||= begin
    file = File.expand_path("elasticsearch-node.gemspec")
    ::Gem::Specification.load(file)
  end
end

desc "Validates the gemspec"
task :gemspec do
  gemspec.validate
end

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

task :package => :gemspec

Rake::TestTask.new(:test) do |test|
  test.libs << "test"
  test.pattern = 'test/**/*_test.rb'

  test.verbose = true
end

task :default => :test

require "elsearch-node/version"

module ElasticSearch 
  module Node
    def self.path
      File.expand_path(File.join(File.dirname(__FILE__), "..", "elasticsearch"))
    end

    def self.binary
      File.join(path, 'bin', 'elasticsearch')
    end

    def self.version
      `#{binary} -v`
    end

    def self.lib
      File.join(path, 'lib')
    end
  end
end

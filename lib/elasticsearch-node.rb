require "elasticsearch-node/version"
require 'elasticsearch-node/client_provider'

module ElasticSearch 
  module Node
    attr_accessor :version
    
    def self.root(*args)
      File.join(File.dirname(__FILE__), "..", *args)
    end
  
    def self.path
      File.expand_path(File.join(root, "elasticsearch-#{version}"))
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
    
    def self.config(name)
      root('configs', name.to_s, "config")
    end
    
    def self.default_config(name)
      ENV["ES_JAVA_OPTS"] = "-Des.path.conf=#{self.config(name)}"
    end
    
    def self.version
      @version || ENV["ES_VERSION"] || "0.19.1"
    end
  end
end

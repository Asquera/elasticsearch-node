module ElasticSearch
  module ClientProvider
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      attr_accessor :default_client_module
    end
    
    def initialize(opts = {}, &block)
      if block
        mod = Module.new(&block)
        extend mod
      elsif opts[:client_module]
        extend opts[:client_module]
      elsif self.class.default_client_module
        extend self.class.default_client_module
      end
    end
  end
end
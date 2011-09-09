
module ElasticSearch
  
end

module ElasticSearch
  module Node
    def self.new(*args)
      if RUBY_ENGINE == 'jruby'
        Native.new(*args)
      else
        External.new(*args)
      end
    end
    
    class External
      def initialize
        
      end
      
      def close
        
      end
    end
  end
end
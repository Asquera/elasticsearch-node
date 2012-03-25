module ElasticSearch
  module Node
    class Remote
      include ElasticSearch::ClientProvider
      
      attr_accessor :port, :ip
      
      def initialize(port, ip)
        this.port = port
        this.ip   = ip
      end

      def port
        Integer(@port)
      end

      def close
        raise "Remote Nodes cannot be closed directly, please use a shutdown request"
      end

    end
  end
  
end
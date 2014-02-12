module ElasticSearch
  module Node
    class Remote
      include ElasticSearch::ClientProvider

      attr_accessor :port, :ip

      def initialize(port, ip)
        self.port = port
        self.ip   = ip
        super()
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

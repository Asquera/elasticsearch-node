require 'elsearch-node'
require 'jruby'

Dir["#{ElasticSearch::Node.lib}/*.jar"].each do |jar|
  require jar
end

module ElasticSearch
  module Node
    class Embedded
      include ElasticSearch::ClientProvider
      
      def initialize(opts = {})
        cluster_name = opts[:cluster_name] || "default"
        settings = org.elasticsearch.common.settings.ImmutableSettings.settingsBuilder.put("cluster.name", cluster_name).put("gateway.type", "none").put("number_of_shards", 1)
        
        @node ||= org.elasticsearch.node.NodeBuilder.nodeBuilder.settings(settings).local(true).node
        super(opts)
      end

      def port
        Integer(socket_address.port)
      end

      def ip
        socket_address.host_string
      end

      def client
        @node.client
      end
      
      def close
        @node.close
      end

      private

        def http_server
          @node.injector.getInstance(org.elasticsearch.http.HttpServer.java_class)
        end

        def socket_address
          http_server.info.address.publishAddress.address
        end
    end
  end
  
end

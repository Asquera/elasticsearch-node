require 'elasticsearch-node'
require 'jruby'

Dir["#{ElasticSearch::Node.lib}/*.jar"].each do |jar|
  require jar
end

module ElasticSearch
  module Node
    class Embedded
      include ElasticSearch::ClientProvider

      def initialize(opts = {})
        node_builder = org.elasticsearch.node.NodeBuilder.nodeBuilder.loadConfigSettings(true)
        settings_builder = org.elasticsearch.common.settings.ImmutableSettings.settingsBuilder
        
        if opts[:config]
          settings_builder.put("path.home", opts[:config])
        end
        
        settings_builder.put(opts[:settings]) if opts[:settings]
        
        tuple = org.elasticsearch.node.internal.InternalSettingsPerparer.prepareSettings(settings_builder.build, true)
        org.elasticsearch.common.logging.log4j.LogConfigurator.configure(tuple.v1());
        @node = node_builder.settings(settings_builder).node
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

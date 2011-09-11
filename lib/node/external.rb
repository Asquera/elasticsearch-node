require 'elsearch-node'

module ElasticSearch
  module Node
    class External
      attr_accessor :process

      def initialize(cluster_name = "default")
        self.process = IO.popen("#{Node.binary} -f", "r")
      end
      
      def port
        unless @port
          parse_ip_and_port
        end

        @port
      end

      def ip
        unless @ip
          parse_ip_and_port
        end

        @ip
      end

      def client

      end

      def close
        puts "killing #{process.pid}"
        Process.kill 15, process.pid
        sleep 2
      end
      
      private
        def parse_ip_and_port
          self.process.each do |line|
            if line =~ /\[http\s*\].*\/(.*):([0-9]+)/
              @ip = $1
              @port = Integer($2)
              break
            end
          end
        end
    end
  end
end

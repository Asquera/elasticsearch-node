require 'elsearch-node'

module ElasticSearch
  module Node
    class External
      include ElasticSearch::ClientProvider

      attr_accessor :process

      def initialize(opts = {})
        if opts[:config]
          ENV["ES_HOME"] = ElasticSearch::Node.config(opts[:config])
        end

        commandline = opts.map {|opt,value| "-Des.#{opt}=#{value}" }.join(" ")

        self.process = IO.popen("#{Node.binary} -f #{commandline}", "r")
        super(opts)
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

      def close
        puts "killing #{process.pid}"
        Process.kill 15, process.pid
        wait_for_closing
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

        def wait_for_closing
          self.process.each do |line|
            if line =~ /node.*closed/
              break
            end
          end
        end
    end
  end
end

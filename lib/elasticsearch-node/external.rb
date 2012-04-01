require 'elasticsearch-node'

module ElasticSearch
  module Node
    class External
      include ElasticSearch::ClientProvider

      attr_accessor :pid

      def initialize(opts = {})
        if opts[:config]
          ENV["ES_HOME"] = ElasticSearch::Node.config(opts[:config])
        end

        commandline = opts.map {|opt,value| "-Des.#{opt}=#{value}" }.join(" ")

        capture_ip_and_port do
          self.pid = Kernel.spawn("#{Node.binary} -f #{commandline}", :out => :out, :err => :err)
        end

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
        $stderr.puts "Killing ElasticSearch node: #{pid}"
        Process.kill 15, pid
        begin
          Process.waitpid pid
        rescue Errno::ECHILD
          # Possible, if process is already gone
        end
      end

      private
        def capture_ip_and_port(&block)
          read, write = IO.pipe

          old_stdout = $stdout.dup
          $stdout.reopen(write)

          yield

          read.each do |line|
            old_stdout << line

            if line =~ /\[http\s*\].*\/(.*):([0-9]+)/
              @ip = $1
              @port = Integer($2)
              break
            end
          end

          $stdout.reopen(old_stdout)
        end
    end
  end
end

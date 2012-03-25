# elasticsearch-node

`elasticsearch-node` is a Ruby library to start, manipulate and shutdown elasticsearch nodes in a controlled fashion. On JRuby, it also provides a native binding to this functionality.

## Usage

```
require 'elasticsearch-node/external'
require 'elasticsearch-node/embedded'
require 'elasticsearch-node/remote'

external = ElasticSearch::Node::External "gateway.type" => "none"
embedded = ElasticSearch::Node::Embedded "gateway.type" => "none"
remote   = ElasticSearch::Node::Remote '127.0.0.1', 9200

[external, embedded, remote].each do |node|
  puts node.ip
  puts node.port
end

embedded.client
```

`elasticsearch-node` provides 3 types of nodes: `External`, `Embedded` and `Remote`. They differ in capabilities:

* `External` nodes are started as an external process and can be started, configured and shut down
* `Embedded` nodes are only available on JRuby and start and embedded Elasticsearch instance. In addition to the capabilities of external nodes, embedded nodes expose the `client` method, which returns a vanilla Elasticsearch client
* `Remote` nodes a standin for nodes not under control by this process: they are only configured using port and ip and have not further capabilities.

## Clients

`elasticsearch-node` also provides a protocol to associate clients with nodes. See this example:

```
n = ElasticSearch::Node::External.new do
  def client
    conn = Faraday.new(:url => "http://#{self.ip}:#{self.port}") do |builder|
      builder.adapter :net_http
    end
  end
end

n.client #=> <#Faraday::Connection...

# or alternatively:

module HTTPClient
  def client
    conn = Faraday.new(:url => "http://#{self.ip}:#{self.port}") do |builder|
      builder.adapter :net_http
    end
  end
end

n = ElasticSearch::Node::External.new :client_module => HTTPClient
```

This allows client implementations to be independent of which kind of nodes they run on (as long as they don't rely on those features).

## Final Remarks

Please be aware that this library does not add any `at_exit`-hooks to your application. Shutdown must be taken care of, as elasticsearch takes some seconds to shut down and killing it can lead to data corruption. In most cases, its as easy as:

    at_exit { node.close }

### License

See `COPYING.md` for all details.
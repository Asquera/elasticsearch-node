module ElasticSearch
  class Cluster
    include ElasticSearch::ClientProvider
    
    attr_accessor :nodes
    
    def initialize(nodes)
      self.nodes = nodes
    end
  end
end
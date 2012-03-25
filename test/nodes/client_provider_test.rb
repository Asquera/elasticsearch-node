require 'test_helper'
require 'node/external'

module DefaultClient
  def client
    conn = Faraday.new(:url => "http://#{self.ip}:#{self.port}") do |builder|
      builder.adapter :net_http
    end
  end
end

context "An external node" do
  context "with inline client definition" do
    setup do
      ElasticSearch::Node::External.new do
        def client
          conn = Faraday.new(:url => "http://#{self.ip}:#{self.port}") do |builder|
            builder.adapter :net_http
          end
        end
      end
    end
    
    teardown do
      topic.close
    end
    
    asserts(:client).kind_of?(Faraday::Connection)
  end
  
  context "with client module as option" do
    setup do
      ElasticSearch::Node::External.new(:client_module => DefaultClient)
    end
    
    teardown do
      topic.close
    end
    
    asserts(:client).kind_of?(Faraday::Connection)
  end
  
  context "with default module" do
    setup do
      ElasticSearch::Node::External.default_client_module = DefaultClient
      ElasticSearch::Node::External.new
    end
    
    teardown do
      ElasticSearch::Node::External.default_client_module = nil
      topic.close
    end
    
    asserts(:client).kind_of?(Faraday::Connection)
  end
end